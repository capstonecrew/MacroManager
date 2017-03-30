//
//  YummlyRouter.swift
//  MacroManager
//
//  Created by Aaron Edwards on 3/29/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Alamofire

enum YummlyRouter : URLRequestConvertible {
    case getItem(id: String)
    case search(query: String, count: Int)
    
    static let baseURL = "http://api.yummly.com/v1/api"
    static let appID = "751cde49"
    static let appKey = "cbe6ee386ee1c2b4226572e1d4fad5bf"
    
    var method: HTTPMethod {
        switch self {
        case .getItem:
            return .get
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getItem(let id):
            return "/recipe/\(id)"
        case .search(_, _):
            return "/recipes"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try YummlyRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getItem(let id):
            let parameters : Parameters = [
                "_app_id" : "\(YummlyRouter.appID)",
                "_app_key" : "\(YummlyRouter.appKey)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .search(let query, let count):
            let parameters : Parameters = [
                "q" : "\(query)",
                "_app_id" : "\(YummlyRouter.appID)",
                "_app_key" : "\(YummlyRouter.appKey)",
                "maxResult" : "\(count)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
