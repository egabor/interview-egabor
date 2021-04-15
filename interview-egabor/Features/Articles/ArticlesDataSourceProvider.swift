//
//  ArticlesDataSourceProvider.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import UIKit

typealias ArticlesDataSource = UICollectionViewDiffableDataSource<ArticleSection, ArticleData>
typealias ArticlesSnapshot = NSDiffableDataSourceSnapshot<ArticleSection, ArticleData>

class ArticlesDataSourceProvider {

    let dataSource: ArticlesDataSource?

    init(_ collectionView: UICollectionView) {
        dataSource = ArticlesDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier,
                                                              for: indexPath) as? ArticleCell
                cell?.setup(with: cellModel.unwrapped)
                return cell
            })
    }

    func applySnapshot(_ cellModels: [ArticleData]) {
        var snapshot = ArticlesSnapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(cellModels, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
