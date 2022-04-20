//
//  DependencyProvider.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Swinject

class DependencyProvider {

    static let shared = DependencyProvider()

    private let container = Container()
    let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                NetworkAssembly(),
                ViewModelAssembly()
            ],
            container: container
        )
    }
}
