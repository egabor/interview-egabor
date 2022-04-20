//
//  ArticleData.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import Foundation

enum ArticleData: Hashable {
    case headerArticle(ArticleCellModel)
    case normalArticle(ArticleCellModel)

    var unwrapped: ArticleCellModel {
        switch self {
        case let .headerArticle(data):
            return data
        case let .normalArticle(data):
            return data
        }
    }

    var cellIdentifier: String {
        switch self {
        case .headerArticle:
            return "ArticleHeaderCell"
        case .normalArticle:
            return "ArticleCell"
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(unwrapped)
    }
}
