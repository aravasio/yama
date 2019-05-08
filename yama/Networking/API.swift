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
    
    /// NOTE: sensitive data should never be stored in either code or plist files.
    /// They are, by definition, vulnerable to binary dumps.
    /// I'm doing this to avoid the unnecesary complexity of dealing with the enclave.
    static let apiKey = "208ca80d1e219453796a7f9792d16776"

    
    /// Language configuration for the requests. This will define the language in which responses will be sent.
    static let language = "en-US"
    
    
    /// Production providers. It provides no debug info on responses and is, thus, lean-oriented.
    fileprivate static let tvShowsProvider = MoyaProvider<ShowApi>()
    fileprivate static let tvGenresProvider = MoyaProvider<GenreApi>()
    
    
    /**
     Extremely verbose providers for debugging purposes.
     Highly adviced not to use this one unless you ought to debug something or are curious what/how it works.
     */
//    fileprivate static let provider = MoyaProvider<ShowApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
//    fileprivate static let tvGenresProvider = MoyaProvider<GenreApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    
    /**
     Fetch the most popular shows.
     
     - Parameters:
         - completion: code to be executed on a succesful request.
     */
    static func getPopularShows(completion: @escaping ([Show]) -> ()) {
        API.fetch(provider: tvShowsProvider, endpoint: ShowApi.popular, returnType: APIShowResults.self, completion: { result in
            completion(result.shows)
        })
    }
    
    
    /**
     Fetch the top-rated shows.
     
     - Parameters:
     - page: the page number we want to fetch data for. Given the high volume of information, pagination is a necessity.
     - completion: code to be executed on a succesful request.
     */
    static func getTopRatedShows(page: Int, completion: @escaping ([Show]) -> ()) {
        API.fetch(provider: tvShowsProvider, endpoint: ShowApi.topRated(page: page), returnType: APIShowResults.self, completion: { result in
            completion(result.shows)
        })
    }
    
    
    /**
     Fetch all genres for TV Shows from TMDb.
     
     - Parameters:
         - completion: code to be executed on a successful request.
     */
    static func getGenres(completion: @escaping ([Genre]) -> ()) {
        API.fetch(provider: tvGenresProvider, endpoint: GenreApi.list, returnType: APIGenresResults.self, completion: {
            completion($0.genres)
        })
    }
    
    /**
     Fetches data from a given Target using a given Moya provider.
     
     - Parameters:
     - provider: A Moya provider.
     - endpoint: A `TargetType`-enum.
     - returnType: The type the responses should be in.
     - completion: What to do after the successful response triggers.
     */
    
    static func fetch<T: TargetType, P: MoyaProvider<T>, R: Decodable>(provider: P, endpoint: T, returnType: R.Type, completion: @escaping (R) -> ()) {
        
        provider.request(endpoint) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(returnType, from: result.data)
                    completion(results)
                } catch let error {
                    print(error)
                }
                
            case let .failure(error):
                print(error)
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
}

