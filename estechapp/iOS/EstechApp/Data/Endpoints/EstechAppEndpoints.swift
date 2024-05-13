//
//  EstechAppEndpoints.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation
import BDRCoreNetwork
import Alamofire

enum EstechAppEndpoints  {
    case login(Parameters)
    case userInfo(Parameters)
    case addChekIn(Parameters)
    case listCheckins
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .userInfo(_):
            return "api/user/user-info"
        case .addChekIn:
            return "api/check-in/new"
        case .listCheckins:
            return "api/check-in"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .userInfo, .addChekIn:
            return .post
        case .listCheckins:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let parameters):
            return parameters
        case .userInfo(let parameters):
            return parameters
        case .addChekIn(let parameters):
            return parameters
        case .listCheckins:
            return nil
        }
    }
}