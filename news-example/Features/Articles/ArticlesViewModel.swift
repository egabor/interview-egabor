//
//  ArticlesViewModel.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import Combine

class ArticlesViewModel {

    // MARK: - Disposables

    var disposables = Set<AnyCancellable>()

    // MARK: - Dependencies

    @Injected private var newsApi: NewsApiProtocol

    // MARK: - Combine Related Variables

    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var viewData: [ArticleData] = []

    var isNextPageLoading: Bool = false
    var hasNextPage: Bool = false
    var articles = [Article]()
    private var keyword: String?
    let pageSize = 20
    var currentPage = 1

    init() {}

    public func reset() {
        viewData = []
        articles = []
    }

    public func loadArticles(keyword: String? = nil) {
        self.keyword = keyword
        currentPage = 0
        let nextPage = currentPage + 1
        startLoading()
        let result = newsApi.getArticles(keyword: keyword, for: nextPage, pageSize: pageSize)
        result.sink(receiveCompletion: { [unowned self] completion in
            self.endLoading()
            switch completion {
            case let .failure(error):
                self.presentError(error)
            default: break
            }
        }, receiveValue: { [unowned self] (list: List<Article>) in
            self.endLoading()
            self.processArticles(list: list)
            self.currentPage = nextPage
        }).store(in: &disposables)
    }

    public func loadNextPage() {
        let nextPage = currentPage + 1
        guard hasNextPage else { return }
        nextPageLoadingStarted()
        let result = newsApi.getArticles(keyword: keyword, for: nextPage, pageSize: pageSize)
        result.sink(receiveCompletion: { [unowned self] completion in
            self.nextPageLoadingEnded()
            switch completion {
            case let .failure(error):
                self.presentError(error)
            default: break
            }
        }, receiveValue: { [unowned self] (list: List<Article>) in
            self.nextPageLoadingEnded()
            self.processArticles(list: list)
            self.currentPage = nextPage
        }).store(in: &disposables)
    }

    // MARK: - Private Helpers

    private func updateHasNextPage(list: List<Article>) {
        hasNextPage = list.totalResults > currentPage * pageSize
    }

    private func processArticles(list: List<Article>) {
        guard (list.articles ?? []).count > 0 else { return }
        updateHasNextPage(list: list)
        articles.append(contentsOf: list.articles ?? [])
        var data = articles
        let firstArticle = data.removeFirst()
        let otherArticles = data

        let headerArticle = createArticleHeaderCellModel(from: firstArticle)
        let others = otherArticles.map { createArticleCellModel(from: $0) }
        var processedArticles = [ArticleData]()
        processedArticles.append(headerArticle)
        processedArticles.append(contentsOf: others)

        viewData = processedArticles
    }

    private func createArticleHeaderCellModel(from article: Article) -> ArticleData {
        return ArticleData.headerArticle(ArticleCellModel(title: article.title,
                                                          urlToImage: article.urlToImage,
                                                          publishedAt: article.publishedAt))
    }

    private func createArticleCellModel(from article: Article) -> ArticleData {
        return ArticleData.normalArticle(ArticleCellModel(title: article.title,
                                                          urlToImage: article.urlToImage,
                                                          publishedAt: article.publishedAt))
    }

    private func presentError(_ error: Error) {
        if let error = error as? NetworkError {
            self.error = error.message
            hasNextPage = false
            return
        }
        self.error = Localized.News.Alert.Error.generalMessage
    }

    // MARK: - Loading Helpers

    private func nextPageLoadingStarted() {
        isNextPageLoading = true
    }

    private func nextPageLoadingEnded() {
        isNextPageLoading = false
    }

    private func startLoading() {
        isLoading = true
    }

    private func endLoading() {
        isLoading = false
    }

}
