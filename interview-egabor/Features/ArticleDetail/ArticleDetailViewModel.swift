//
//  ArticleDetailViewModel.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import Foundation
import RxCocoa

class ArticleDetailViewModel {

    let imageUrl = BehaviorRelay<String?>(value: nil)
    let title = BehaviorRelay<String>(value: "")
    let content = BehaviorRelay<String>(value: "")

    init() {}

    public func setup(with article: Article) {
        imageUrl.accept(article.urlToImage)
        title.accept(article.title)
        content.accept(article.content)
    }
}
