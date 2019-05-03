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
    
    /// All cases are entirely experimental in nature. I'm messing around with different TMDb endpoints to
    /// check out which ones I'm more comfortable with for the purpose of the project.
    /// They might be implemented as endpoints, but not necessarily consumed anywhere else in the app.
    case popular
    case topRated(page: Int)
    case upcoming(page: Int)
    
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
        case .upcoming:
            return "/upcoming"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular, .topRated, .upcoming:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .popular:
            return ["api_key": API.apiKey, "language": API.language]
        case .topRated(let page):
            return ["page": page, "api_key": API.apiKey, "language": API.language]
        case .upcoming(let page):
            return ["page": page, "api_key": API.apiKey, "language": API.language]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .popular, .topRated, .upcoming:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .popular, .topRated, .upcoming:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: self.parameterEncoding)
        }
    }
    
    /// TMDb uses query strings, so headers will just be nil.
    var headers: [String : String]? { return nil }
    
    /// sampleData is the way Moya helps streamlines mocking of data. For now we'll just return Data(). If time allows for it, we can eventually implement this.
    var sampleData: Data { return Data() }
}
