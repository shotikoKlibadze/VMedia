//
//  Network.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct Network {
    
    enum ResponseStatus: Int {
        case success = 200
    }
    
    enum RequestMethod: String {
        case get    = "GET"
        case post   = "POST"
        case delete = "DELETE"
        case put    = "PUT"
    }
}
