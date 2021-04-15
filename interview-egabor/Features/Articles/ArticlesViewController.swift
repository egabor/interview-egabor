//
//  ArticlesViewController.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import UIKit
import RxSwift

class ArticlesViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UISearchBar!

    @Injected private var viewModel: ArticlesViewModel

    lazy var articlesDataSourceProvider: ArticlesDataSourceProvider? = {
        return ArticlesDataSourceProvider(collectionView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        viewModel.loadArticles(keyword: searchField.text)
    }

    private func setup() {
        title = Localized.News.title
        setupSearchField()
        setupTableView()
        setupBindings()
    }

    private func setupSearchField() {
        // Set initial text
        searchField.text = "Bitcoin"
        searchField.placeholder = Localized.News.SearchField.placeholder
        searchField.delegate = self
    }

    private func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = articlesDataSourceProvider?.dataSource
    }

    private func setupBindings() {
        viewModel.error.asObservable().subscribe(onNext: { [weak self] message in
            guard let self = self, let message = message else { return }
            self.showError(with: message)
        }).disposed(by: disposeBag)

        viewModel.isLoading.asObservable().subscribe(onNext: { [weak self] isLoading in
            if isLoading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }).disposed(by: disposeBag)

        viewModel.viewData.asObservable().subscribe(onNext: { [weak self] viewData in
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.articlesDataSourceProvider?.applySnapshot(viewData)
        }).disposed(by: disposeBag)

        collectionView.rx.didScroll.map { [weak self] in
            return self?.shouldLoadNextPage() ?? false
        }
        .asObservable()
        .distinctUntilChanged()
        .subscribe(onNext: { shouldLoadNextPage in
            guard shouldLoadNextPage else { return }
            self.viewModel.loadNextPage()
        }).disposed(by: disposeBag)
    }

    // MARK: - Alert

    private func showError(with message: String) {
        let alertController = UIAlertController(title: Localized.News.Alert.Error.title,
                                                message: message,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: Localized.News.Alert.Error.dismiss,
                                                style: .default,
                                                handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Loading

    private func showLoading() {
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }

    private func hideLoading() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }

    // MARK: - Paging Helpers

    private func shouldLoadNextPage() -> Bool {
        return isCollectionViewBottomNear() && !viewModel.isNextPageLoading.value && viewModel.hasNextPage.value
    }

    private func isCollectionViewBottomNear() -> Bool {
        if collectionView.contentSize.height == 0.0 { return false }
        return (collectionView.contentOffset.y+collectionView.bounds.height) > (collectionView.contentSize.height-500)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.Articles.showArticleDetail.rawValue,
           let destination = segue.destination as? ArticleDetailViewController {
            if let data = sender as? Article {
                destination.viewModel.setup(with: data)
            }
        }
    }
}

extension ArticlesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadArticles(keyword: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

// MARK: - CollectionViewView Delegate And Delegate Flow Layout

extension ArticlesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard viewModel.viewData.value.count > indexPath.item else { return .zero }
        var cellHeight: CGFloat = 0.0
        let data = viewModel.viewData.value[indexPath.item]
        switch data {
        case .headerArticle:
            cellHeight = 360.0
        case .normalArticle:
            cellHeight = 120.0
        }
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = viewModel.articles[indexPath.item]
        performSegue(withIdentifier: StoryboardSegue.Articles.showArticleDetail.rawValue, sender: cellModel)
    }
}
