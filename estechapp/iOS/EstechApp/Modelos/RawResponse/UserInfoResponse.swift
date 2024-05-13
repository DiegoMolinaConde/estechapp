//
//  UserInfoResponse.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation

struct UserInfoResponse: Codable {
    let name: String?
    let lastname: String?
    let email: String?
    let id: Int
}
