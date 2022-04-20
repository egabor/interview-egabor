//
//  GeneralApi.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import Combine

public class NewsApi: BaseApi, NewsApiProtocol {

    public func getArticles(keyword: String? = nil, for page: Int = 1, pageSize: Int) -> Future<List<Article>, Error> {
        var query = [URLQueryItem]()
        if let keyword = keyword {
            query.append(URLQueryItem(name: "q", value: keyword))
        }
        query.append(URLQueryItem(name: "page", value: "\(page)"))
        query.append(URLQueryItem(name: "pageSize", value: "\(pageSize)"))
        let request = NetworkRequest(baseUrl, "/everything", .get, headers, queryItems: query)
        return buildRequest(with: request)
    }
}
