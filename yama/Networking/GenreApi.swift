//
//  MockApi.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya

enum GenreApi: TargetType {
    
    /// All cases are entirely experimental in nature. I'm messing around with different TMDb endpoints to
    /// check out which ones I'm more comfortable with for the purpose of the project.
    /// They might be implemented as endpoints, but not necessarily consumed anywhere else in the app.
    case list
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/tv") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .list:
            return "/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .list:
            return ["api_key": API.apiKey, "language": API.language]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .list:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: self.parameterEncoding)
        }
    }
    
    /// TMDb uses query strings, so headers will just be nil.
    var headers: [String : String]? { return nil }
    
    /// sampleData is the way Moya helps streamlines mocking of data. For now we'll just return Data(). If time allows for it, we can eventually implement this.
    var sampleData: Data { return Data() }
}
