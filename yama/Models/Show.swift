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
    let overview: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case videoPath
        case backdrop = "backdrop_path"
        case title = "original_name"
        case releaseDate = "first_air_date"
        case rating = "vote_average"
        case overview
    }
}

/*
 Show model example:
 
 
 {
 "original_name": "Arrow",
 "genre_ids": [
 80,
 18,
 9648,
 10759
 ],
 "name": "Arrow",
 "popularity": 306.471,
 "origin_country": [
 "US"
 ],
 "vote_count": 2198,
 "first_air_date": "2012-10-10",
 "backdrop_path": "/dKxkwAJfGuznW8Hu0mhaDJtna0n.jpg",
 "original_language": "en",
 "id": 1412,
 "vote_average": 5.9,
 "overview": "Spoiled billionaire playboy Oliver Queen is missing and presumed dead when his yacht is lost at sea. He returns five years later a changed man, determined to clean up the city as a hooded vigilante armed with a bow.",
 "poster_path": "/mo0FP1GxOFZT4UDde7RFDz5APXF.jpg"
 }
 
 
 */
