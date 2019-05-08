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
    init(data: AnyObject) {
        print(data)
        id = data.value(forKey: "id") as? Int
        
        if let path = data.value(forKey: "posterPath") as? String {
            self.posterPath = path
        } else {
            self.posterPath = nil
        }
        
        if let path = data.value(forKey: "videoPath") as? String {
            self.videoPath = path
        } else {
            self.videoPath = nil
        }
        
        if let backdrop = data.value(forKey: "backdrop") as? String {
            self.backdrop = backdrop
        } else {
            self.backdrop = ""
        }
        
        if let title = data.value(forKey: "title") as? String {
            self.title = title
        } else {
            self.title = ""
        }
        
        if let release = data.value(forKey: "releaseDate") as? String {
            self.releaseDate = release
        } else {
            self.releaseDate = ""
        }
        
        if let rating = data.value(forKey: "rating") as? Double {
            self.rating = rating
        } else {
            self.rating = 0
        }
        
        if let count = data.value(forKey: "voteCount") as? Int {
            self.voteCount = count
        } else {
            self.voteCount = 0
        }
        
        if let overview = data.value(forKey: "overview") as? String {
            self.overview = overview
        } else {
            self.overview = ""
        }
        
        if let genres = data.value(forKey: "genres") as? [Int] {
            self.genres = genres
        } else {
            self.genres = []
        }
        
        if let origin = data.value(forKey: "countryOfOrigin") as? [String] {
            self.countryOfOrigin = origin
        } else {
            self.countryOfOrigin = []
        }
        
        if let language = data.value(forKey: "originalLanguage") as? String {
            self.originalLanguage = language
        } else {
            self.originalLanguage = ""
        }
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
