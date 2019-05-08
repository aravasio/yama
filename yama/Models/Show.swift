//
// Show.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

struct Show: Codable {
    let id: Int!
    let posterPath: String?
    let videoPath: String?
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let voteCount: Int
    let overview: String
    let genres: [Int]
    let countryOfOrigin: [String]
    let originalLanguage: String
    
    // Init created for the specific purpose of passing raw CoreData to it and map it to an actual in-memory object
    // I can more easily use across the app.
    init?(data: AnyObject) {
        print(data)

        guard
            let id = data.value(forKey: "id") as? Int,
            let posterPath = data.value(forKey: "posterPath") as? String,
            let videoPath = data.value(forKey: "videoPath") as? String,
            let backdrop = data.value(forKey: "backdrop") as? String,
            let title = data.value(forKey: "title") as? String,
            let release = data.value(forKey: "releaseDate") as? String,
            let rating = data.value(forKey: "rating") as? Double,
            let count = data.value(forKey: "voteCount") as? Int,
            let overview = data.value(forKey: "overview") as? String,
            let genres = data.value(forKey: "genres") as? [Int],
            let origin = data.value(forKey: "countryOfOrigin") as? [String],
            let language = data.value(forKey: "originalLanguage") as? String else {
                return nil
        }
        
        self.id = id
        self.posterPath = posterPath
        self.videoPath = videoPath
        self.backdrop = backdrop
        self.title = title
        self.releaseDate = release
        self.rating = rating
        self.voteCount = count
        self.overview = overview
        self.genres = genres
        self.countryOfOrigin = origin
        self.originalLanguage = language
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case videoPath
        case backdrop = "backdrop_path"
        case title = "original_name"
        case releaseDate = "first_air_date"
        case rating = "vote_average"
        case voteCount = "vote_count"
        case overview
        case genres = "genre_ids"
        case countryOfOrigin = "origin_country"
        case originalLanguage = "original_language"
    }
}
