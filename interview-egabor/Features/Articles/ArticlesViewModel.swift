//
//  ArticlesViewModel.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import RxSwift
import RxCocoa
import PromiseKit

class ArticlesViewModel {

    @Injected private var newsApi: NewsApiProtocol

    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<String?>()
    let viewData = BehaviorRelay<[ArticleData]>(value: [])
    let isNextPageLoading = BehaviorRelay<Bool>(value: false)
    let hasNextPage = BehaviorRelay<Bool>(value: false)
    var articles = [Article]()
    private var keyword: String?

    let pageSize = 20
    var currentPage = 1

    init() {}

    public func reset() {
        viewData.accept([])
        articles = []
    }

    public func loadArticles(keyword: String? = nil) {
        self.keyword = keyword
        currentPage = 0
        let nextPage = currentPage + 1
        startLoading()
        firstly {
            newsApi.getArticles(keyword: keyword, for: nextPage, pageSize: pageSize)
        }.done { [weak self] list in
            self?.reset()
            self?.processArticles(list: list)
            self?.currentPage = nextPage
        }.catch { [weak self] error in
            self?.presentError(error)
        }.finally { [weak self] in
            self?.endLoading()
        }
    }

    public func loadNextPage() {
        nextPageLoadingStarted()
        let nextPage = currentPage + 1
        guard hasNextPage.value else { return }
        firstly {
            newsApi.getArticles(keyword: keyword, for: nextPage, pageSize: pageSize)
        }.done { [weak self] list in
            self?.processArticles(list: list)
            self?.currentPage = nextPage
        }.catch { [weak self] error in
            self?.presentError(error)
        }.finally { [weak self] in
            self?.nextPageLoadingEnded()
        }
    }

    // MARK: - Private Helpers

    private func updateHasNextPage(list: List<Article>) {
        hasNextPage.accept(list.totalResults > currentPage * pageSize)
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

        viewData.accept(processedArticles)
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
            self.error.onNext(error.message)
            hasNextPage.accept(false)
            return
        }
        self.error.onNext(Localized.News.Alert.Error.generalMessage)
    }

    // MARK: - Loading Helpers

    private func nextPageLoadingStarted() {
        isNextPageLoading.accept(true)
    }

    private func nextPageLoadingEnded() {
        isNextPageLoading.accept(false)
    }

    private func startLoading() {
        isLoading.accept(true)
    }

    private func endLoading() {
        isLoading.accept(false)
    }

}
