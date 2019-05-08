//
//  Genre.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int!
    let name: String!
    
    // Init created for the specific purpose of passing raw CoreData to it and map it to an actual in-memory object
    // I can more easily use across the app.
    init?(data: AnyObject) {
        guard let id = data.value(forKey: "id") as? Int,
            let name = data.value(forKey: "name") as? String else { return nil }
        
        self.id = id
        self.name = name
    }
}
