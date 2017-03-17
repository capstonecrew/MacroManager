//
//  EdamamRouter.swift
//  MacroManager
//
//  Created by Brad Cooley on 11/14/16.
//  Copyright © 2016 Brad Cooley. All rights reserved.
//

import Alamofire

enum EdamamRouter : URLRequestConvertible {
    case search(query: String, count: Int)
    
    static let baseURL = "https://api.edamam.com/search"
    static let appID = "6b8e234e"
    static let appKey = "b2f155472da8765e9165d0b84a50a06c"
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
//    var path: String {
//        switch self {
//        case .search(let query, _):
//            return "/search/\(query)"
//
//        }
//    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try EdamamRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .search(let q, let count):
    
            let parameters : Parameters = [
                "q": "\(q)",
                "from": "0",
                "to": "\(count)",
                "appId" : "\(EdamamRouter.appID)",
                "appKey" : "\(EdamamRouter.appKey)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            print(urlRequest)
        }
        
        return urlRequest
    }
}

