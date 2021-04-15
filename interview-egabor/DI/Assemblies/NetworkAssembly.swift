//
//  NetworkAssembly.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Swinject

class NetworkAssembly: Assembly {

    func assemble(container: Container) {
        let baseUrl = Env.baseURL
        let apiKey = Env.apiKey

        container.register(JSONDecoder.self) { _ in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        }.inObjectScope(.container)

        container.register(JSONEncoder.self) { _ in
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            return encoder
        }.inObjectScope(.container)

        container.register(NewsApiProtocol.self) { _ in
            NewsApi(baseUrl: baseUrl, apiKey: apiKey)
        }.inObjectScope(.container)

    }
}
