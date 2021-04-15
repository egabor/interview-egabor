//
//  NewsApiProtocol.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation
import PromiseKit

public protocol NewsApiProtocol {

    func getArticles(keyword: String?, for page: Int, pageSize: Int) -> Promise<List<Article>>
}
