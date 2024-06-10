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
    case listCheckins(id: Int)
    case listMentoringsByTeacher(id: Int)
    case listMentoringsByStudent(id: Int)
    case listGrouos(id: Int)
    
    case updateMentoring(id: Int, Parameters)
    case createeMentoring(Parameters)

    var path: String {
        switch self {
        case .login:
            return "login"
        case .userInfo(_):
            return "api/user/user-info"
        case .addChekIn:
            return "api/check-in/new"
        case .listCheckins(let id):
            return "api/check-in/by-user/\(id)"
        case .listMentoringsByTeacher(let id):
            return "api/mentoring/by-teacher/\(id)"
        case .listMentoringsByStudent(let id):
            return "api/mentoring/by-student/\(id)"
        case .updateMentoring(id: let id, _):
            return "api/mentoring/\(id)"
        case .createeMentoring(_):
            return "api/mentoring/"
        case .listGrouos(id: let id):
            return "api/group/by-user/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .userInfo, .addChekIn, .createeMentoring:
            return .post
        case .updateMentoring:
            return .put
        case .listCheckins, .listMentoringsByTeacher, .listGrouos:
            return .get
        case .listMentoringsByStudent:
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
        case .createeMentoring(let parameters):
            return parameters
        case .updateMentoring(_, let parameters):
            return parameters
        case .listCheckins, .listMentoringsByTeacher, .listMentoringsByStudent, .listGrouos:
            return nil
        }
    }
}
