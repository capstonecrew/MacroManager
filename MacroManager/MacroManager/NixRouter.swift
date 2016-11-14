//
//  NixRouter.swift
//  MacroManager
//
//  Created by Brad Cooley on 11/14/16.
//  Copyright © 2016 Brad Cooley. All rights reserved.
//

import Alamofire

enum NixRouter : URLRequestConvertible {
    case getItem(id: String)
    case search(query: String, page: Int)
    
    static let baseURL = "https://api.nutritionix.com/v1_1"
    static let appID = "XXXXXXX"
    static let appKey = "XXXXXXX"
    static let perPage = 10
    
    var method: HTTPMethod {
        switch self {
        case .getItem:
            return .get
        case .search:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getItem:
            return "/item"
        case .search:
            return "/search"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NixRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getItem(let id):
            let parameters : Parameters = [
                "id" : "\(id)",
                "appId" : "\(NixRouter.appID)",
                "appKey" : "\(NixRouter.appKey)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
