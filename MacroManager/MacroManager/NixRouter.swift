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
    static let appID = "cb97eaa1"
    static let appKey = "8b25255f947b1e4e766723450a580578"
    static let perPage = 10
    
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
        case .getItem:
            return "/item"
        case .search(let query, _):
            return "/search/\(query)"
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
        case .search(_, let page):
            let pageStart = page * NixRouter.perPage
            let pageEnd = pageStart + NixRouter.perPage
            
            let parameters : Parameters = [
                "results" : "\(pageStart):\(pageEnd)",
                "fields" : "*",
                "appId" : "\(NixRouter.appID)",
                "appKey" : "\(NixRouter.appKey)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
