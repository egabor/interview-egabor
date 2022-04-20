//
//  NewsApiProtocol.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import Combine

public protocol NewsApiProtocol {

    func getArticles(keyword: String?, for page: Int, pageSize: Int) -> Future<List<Article>, Error>
}
