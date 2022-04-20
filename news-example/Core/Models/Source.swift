//
//  Source.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation

public struct Source: Codable, Hashable {
    public var id: String?
    public var name: String

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
