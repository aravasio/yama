//
//  GenresManager.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

/// "Genres" so far are a single-time call kind of structre given how rather static this categorization progression is.
/// This manager stores the fetched 'genres' so we can more easily use them (particularly, search genres by ID).
class GenresManager {
    
    static let shared = GenresManager()
    
    var genres: [Genre] = []
    
    /// Filters through the array and returns the genre with a matching id, if any. Returns nil otherwise.
    func getGenre(for id: Int) -> Genre? {
        return genres.first { $0.id == id }
    }
}
