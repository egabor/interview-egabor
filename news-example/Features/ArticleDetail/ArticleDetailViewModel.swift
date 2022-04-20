//
//  ArticleDetailViewModel.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import Foundation
import Combine

class ArticleDetailViewModel {

    @Published var imageUrl: String?
    @Published var title: String = ""
    @Published var content: String = ""

    init() {}

    public func setup(with article: Article) {
        imageUrl = article.urlToImage
        title = article.title
        content = article.content
    }
}
