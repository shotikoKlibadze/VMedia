//
//  TvGuideEndpoint.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

enum TvGuideEndpoint<R> {
    typealias Response = R
    
    case getTvChannels
    case getTvProgramms
}

extension TvGuideEndpoint: Endpoint {
   
    var requestMethod: Network.RequestMethod {
        switch self {
        case .getTvChannels:
            return .get
        case .getTvProgramms:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTvChannels:
            return "https://demo-c.cdn.vmedia.ca/json/Channels"
        case .getTvProgramms:
            return "https://demo-c.cdn.vmedia.ca/json/ProgramItems"
        }
    }
    //Add headers to endpoint
    var headerParameters: [String : Any]? {
        var params = [String : String]()
        switch self {
        case .getTvChannels:
            break
        case .getTvProgramms:
            break
        }
        return params
    }
    //Add quary parameters to endpoint
    var quaryParameters: [String : Any]? {
        var params = [String : String]()
        switch self {
        case .getTvChannels:
            break
        case .getTvProgramms:
            break
        }
        return params
    }
}
