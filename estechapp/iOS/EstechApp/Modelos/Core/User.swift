//
//  User.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation
struct User {
    let firstName: String
    let lastName: String
    let email: String
    let id: Int
    let role: SessionRole
    
    var fullName: String {
        return firstName + " " + lastName
    }
}
