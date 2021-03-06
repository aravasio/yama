//
//  APIMovieResults.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

// Model for the response format of TMDB for Movies.
struct APIMovieResults: Codable {
    let page: Int
    let movies: [Movie]
    let results: Int
    let pages: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case results = "total_results"
        case pages = "total_pages"
        case movies = "results"
    }
}
