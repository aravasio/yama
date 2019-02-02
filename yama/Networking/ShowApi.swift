//
//  ShowApi.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

import Foundation
import Moya

enum ShowApi: TargetType {
    
    case popular
    case topRated(page: Int)
    case newShows(page: Int)
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        case .newShows:
            return "/now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular, .topRated, .newShows:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .popular:
            return ["api_key": API.apiKey]
        case .topRated(let page), .newShows(let page):
            return ["page": page, "api_key": API.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .popular, .topRated, .newShows:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .popular, .topRated, .newShows:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: self.parameterEncoding)
        }
    }
    
    /// TMDb uses query strings, so headers will just be nil.
    var headers: [String : String]? { return nil }
    
    /// sampleData is the way Moya helps streamlines mocking of data. For now we'll just return Data(). If time allows for it, we can eventually implement this.
    var sampleData: Data { return Data() }
}
