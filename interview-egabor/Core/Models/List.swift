//
//  List.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation

public struct List<T: Codable>: Codable {
    public var status: String
    public var totalResults: Int
    public var articles: [T]?
}
