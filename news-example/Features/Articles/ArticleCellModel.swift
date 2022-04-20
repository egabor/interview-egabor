//
//  ArticleCellModel.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation

public class ArticleHashable: Hashable {
    public static func == (lhs: ArticleHashable, rhs: ArticleHashable) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public var uuid = UUID()

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

public class ArticleCellModel: ArticleHashable {
    public var title: String
    public var urlToImage: String?
    public var publishedAt: Date

    init(title: String,
         urlToImage: String?,
         publishedAt: Date) {
        self.title = title
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
