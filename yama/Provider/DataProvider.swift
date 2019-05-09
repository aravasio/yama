//
//  DataProvider.swift
//  yama
//
//  Created by Alejandro Ravasio on 08/05/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Reachability

/// Determines where to go for data.
/// If the device's connected to the internet (Reachability), then it fetches remotely.
/// It fetches locally from CoreData, if any data is available, otherwise.

class DataProvider {
    
    /// Flags internet access from this device. It's used to know if we should try to fetch data remote or locally.
    fileprivate static let isConnected = Reachability()?.connection != Reachability.Connection.none
    
    /// My database manager. I use it to interface with CoreData.
    fileprivate static let dbm = DatabaseManager()
    
    /**
     Fetch all genres for TV Movies. If it's not connected to the internet, it will fetch data (if any available)
     from CoreData.
     
     - Parameters:
     - completion: code to be executed on a successful request.
     */
    static func getGenres(completion: @escaping ([Genre]) -> ()) {
        if isConnected {
            // Remote call
            API.getGenres(completion: { genres in
                completion(genres)
                dbm.store(genres: genres)
            })
        } else {
            //CoreData
            completion(dbm.fetchGenres())
        }
    }

    
    /**
     Fetch the most popular movies. If it's not connected to the internet, it will fetch data (if any available)
     from CoreData.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    static func getPopularMovies(completion: @escaping ([Movie]) -> ()) {
        if isConnected {
            // Remote call
            API.getPopularMovies(page: 1,completion: { movies in
                completion(movies)
                DataProvider.dbm.store(movies: movies, for: "Popular")
            })
        } else {
            //CoreData
            completion(dbm.fetchMovies(for: "Popular"))
        }
    }
    
    
    /**
     Fetch the Top Rated movies. If it's not connected to the internet, it will fetch data (if any available)
     from CoreData.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    static func getTopRatedMovies(completion: @escaping ([Movie]) -> ()) {
        if isConnected {
            // Remote call
            API.getTopRatedMovies(page: 1, completion:  { movies in
                completion(movies)
                DataProvider.dbm.store(movies: movies, for: "TopRated")
            })
        } else {
            //CoreData
            completion(dbm.fetchMovies(for: "TopRated"))
        }
    }
    
    
    /**
     Fetch the upcoming movies. If it's not connected to the internet, it will fetch data (if any available)
     from CoreData.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    static func getUpcomingMovies(completion: @escaping ([Movie]) -> ()) {
        if isConnected {
            // Remote call
            API.getTopRatedMovies(page: 1, completion:  { movies in
                completion(movies)
                DataProvider.dbm.store(movies: movies, for: "Upcoming")
            })
        } else {
            //CoreData
            completion(dbm.fetchMovies(for: "Upcoming"))
        }
    }
    
    
    // Interface to wrap these methods.
    static func getMovies(for type: MovieType, completion: @escaping ([Movie])-> ()) {
        switch type {
        case .popular:
            getPopularMovies(completion: completion)
        case .topRated:
            getTopRatedMovies(completion: completion)
        case .upcoming:
            getUpcomingMovies(completion: completion)
        }
    }
    
    
}
