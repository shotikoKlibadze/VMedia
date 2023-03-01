//
//  Endpoint.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

protocol Endpoint {
    associatedtype Response
    
    var requestMethod: Network.RequestMethod { get }
    var path: String { get }
    var headerParameters: [String: Any]? { get }
    var quaryParameters: [String: Any]? { get }
}
