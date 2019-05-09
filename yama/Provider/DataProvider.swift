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
     Fetch all genres for TV Shows. If it's not connected to the internet, it will fetch data (if any available)
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
     Fetch the most popular shows. If it's not connected to the internet, it will fetch data (if any available)
     from CoreData.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    static func getPopularShows(completion: @escaping ([Show]) -> ()) {
        if isConnected {
            // Remote call
            API.getPopularShows(completion: { shows in
                completion(shows)
                DataProvider.dbm.store(shows: shows, for: "Popular")
            })
        } else {
            //CoreData
            completion(dbm.fetchShows(for: "Popular"))
        }
    }
    
}