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
    static let appID = "67b57b76"
    static let appKey = "321f7a18064a4b626261f5fb80af51d6"
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
                "sort" : ["field" : "_score", "order" : "desc"],
                //"filters" : ["item_type":3],
                "appId" : "\(NixRouter.appID)",
                "appKey" : "\(NixRouter.appKey)"
            ]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
