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
    static let language = "es-AR"
    
    
    /// Production providers. It provides no debug info on responses and is, thus, lean-oriented.
    static let tvShowsProvider = MoyaProvider<ShowApi>()
    static let tvGenresProvider = MoyaProvider<GenreApi>()
    
    
    /**
     Extremely verbose providers for debugging purposes.
     Highly adviced not to use this one unless you ought to debug something or are curious what/how it works.
     */
//    static let provider = MoyaProvider<ShowApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
//    static let tvGenresProvider = MoyaProvider<GenreApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    
    /// Due to the tiny scope of the app, all tv requests will basically map to this.
    typealias ShowsResponse = (([Show]) -> ())
    
    
    typealias GenresResponse = (([Genre]) -> ())
    
    
    /**
     Fetch the most popular shows.
     
     - Parameters:
         - completion: code to be executed on a succesful request.
     */
    static func getPopularShows(completion: @escaping ShowsResponse) {
        let target = ShowApi.popular
        API.sendShowRequest(to: target, completion: completion)
    }
    
    
    /**
     Fetch the top-rated shows.
     
     - Parameters:
     - page: the page number we want to fetch data for. Given the high volume of information, pagination is a necessity.
     - completion: code to be executed on a succesful request.
     */
    static func getTopRatedShows(page: Int, completion: @escaping ShowsResponse) {
        let target = ShowApi.topRated(page: page)
        API.sendShowRequest(to: target, completion: completion)
    }
    
    
    /**
     Underlying method that handles the actual request to a given target.
     
     - Parameters:
         - target: The endpoint where we want to send our request.
         - completion: code to be executed on a successful request.
     */
    fileprivate static func sendShowRequest(to target: ShowApi, completion: @escaping ShowsResponse) {
        tvShowsProvider.request(target) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(APIShowResults.self, from: result.data)
                    completion(results.shows)
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
    
    
    /**
     Fetch all genres for TV Shows from TMDb.
     
     - Parameters:
         - target: The endpoint where we want to send our request.
         - completion: code to be executed on a successful request.
     */
    static func getGenres(completion: @escaping GenresResponse) {
        let target = GenreApi.list
        tvGenresProvider.request(target) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(APIGenresResults.self, from: result.data)
                    completion(results.genres)
                } catch let error {
                    print(error)
                }
                
            case let .failure(error): print(error)
            }
        }
    }
}

