//
//  APIVideosResult.swift
//  yama
//
//  Created by Alejandro Ravasio on 09/05/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

// Video model for Videos. WIP.
struct APIVideoResults: Codable {
    
    let id: Int!
    let videos: [Video]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
}
