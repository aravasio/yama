//
//  APIShowResults.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

// Model for the response format of TMDB for Shows.
struct APIShowResults: Codable {
    let page: Int
    let shows: [Show]
    let results: Int
    let pages: Int

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "total_results"
        case pages = "total_pages"
        case shows = "results"
    }
}
