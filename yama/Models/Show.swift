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

        guard let id = data.value(forKey: "id") as? Int else { return nil }
    
        self.id = id
        self.posterPath = data.value(forKey: "posterPath") as? String ?? ""
        self.videoPath = data.value(forKey: "videoPath") as? String ?? ""
        self.backdrop = data.value(forKey: "backdrop") as? String ?? ""
        self.title = data.value(forKey: "title") as? String ?? ""
        self.releaseDate = data.value(forKey: "releaseDate") as? String ?? ""
        self.rating = data.value(forKey: "rating") as? Double ?? 0
        self.voteCount = data.value(forKey: "voteCount") as? Int ?? 0
        self.overview = data.value(forKey: "overview") as? String ?? ""
        self.genres = data.value(forKey: "genres") as? [Int] ?? []
        self.countryOfOrigin = data.value(forKey: "countryOfOrigin") as? [String] ?? []
        self.originalLanguage = data.value(forKey: "originalLanguage") as? String ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case videoPath
        case backdrop = "backdrop_path"
        case title = "name"
        case releaseDate = "first_air_date"
        case rating = "vote_average"
        case voteCount = "vote_count"
        case overview
        case genres = "genre_ids"
        case countryOfOrigin = "origin_country"
        case originalLanguage = "original_language"
    }
}
