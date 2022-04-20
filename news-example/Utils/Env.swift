//
//  Env.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Foundation

public struct Env {

    // MARK: - Keys
    enum PlistKeys {
        static let baseURL = "BASE_URL"
        static let apiKey = "API_KEY"
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            print("Plist file not found.")
            return [:]
        }
        return dict
    }()

    static let baseURL: String = {
        guard let baseURLstring = Env.infoDictionary[PlistKeys.baseURL] as? String else {
            print("Base URL not set in plist file.")
            return ""
        }
        guard URL(string: baseURLstring) != nil else {
            print("Base URL is invalid.")
            return ""
        }
        return baseURLstring
    }()

    static let apiKey: String = {
        guard let apiKey = Env.infoDictionary[PlistKeys.apiKey] as? String else {
            print("API Key is not set in plist file.")
            return ""
        }
        return apiKey
    }()

}
