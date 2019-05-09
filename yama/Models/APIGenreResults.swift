//
//  APIGenreResults.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

// Model for the response format of TMDB for Genres.
struct APIGenresResults: Codable {
    let genres: [Genre]
}
