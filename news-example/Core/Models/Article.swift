//
//  Article.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation

public protocol ArticleProtocol: Hashable {
    var source: Source { get }
    var author: String? { get }
    var title: String { get }
    var description: String? { get }
    var url: String { get }
    var urlToImage: String? { get }
    var publishedAt: Date { get }
    var content: String { get }
}

public struct Article: ArticleProtocol, Codable {
    public var source: Source
    public var author: String?
    public var title: String
    public var description: String?
    public var url: String
    public var urlToImage: String?
    public var publishedAt: Date
    public var content: String
}
