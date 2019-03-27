//
//  GenresManager.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

class GenresManager {
    
    static let shared = GenresManager()
    
    var genres: [Genre] = []
    
    func getGenre(for id: Int) -> Genre? {
        return genres.first { $0.id == id }
    }
}
