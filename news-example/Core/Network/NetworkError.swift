//
//  NetworkError.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import Foundation

public struct NetworkError: Codable, Error {
    let status: String
    let code: String
    let message: String
}
