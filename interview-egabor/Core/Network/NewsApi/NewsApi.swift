//
//  GeneralApi.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import PromiseKit

public class NewsApi: BaseApi, NewsApiProtocol {

    public func getArticles(keyword: String? = nil, for page: Int = 1, pageSize: Int) -> Promise<List<Article>> {
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
