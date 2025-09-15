//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import Foundation

struct URLParameterParser {
    
    static func getQueryParameters(from urlString: String) -> [String: String] {
        guard let urlComponents = URLComponents(string: urlString),
              let queryItems = urlComponents.queryItems else {
            return [:]
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
}

