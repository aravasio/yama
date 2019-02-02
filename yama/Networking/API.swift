//
//  API.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya

/// Access hub to all TMDb endpoints
class API {
    
    /// sensitive data should never be stored in either code or plist files.
    /// They are, by definition, vulnerable to binary dumps.
    /// I'm doing this to avoid the unnecesary complexity of dealing with the enclave.
    static let apiKey = "208ca80d1e219453796a7f9792d16776"
    
//    static let provider = MoyaProvider<ShowApi>()
    static let provider = MoyaProvider<ShowApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    typealias showsResponse = (([Show]) -> ())
    static func getPopularShows(page: Int, completion: @escaping showsResponse) {
        provider.request(.popular) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: result.data)
                    completion(results.shows)
                } catch let error {
                    print(error)
                }
            case let .failure(error): print(error)
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
}

