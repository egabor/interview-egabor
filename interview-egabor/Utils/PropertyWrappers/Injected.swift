//
//  Injected.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Swinject

@propertyWrapper
struct Injected<T> {
    private let resolver = (DependencyProvider.shared.assembler.resolver as! Container).synchronize() // swiftlint:disable:this force_cast line_length

    init() {}

    lazy var wrappedValue: T = {
        return resolver.resolve(T.self)!
    }()
}
