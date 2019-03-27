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
