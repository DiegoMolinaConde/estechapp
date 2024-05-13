//
//  CheckInResponse.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation
struct CheckInResponse: Codable {
    let date: String
    let checkIn: Bool
    let userId: Int
}
