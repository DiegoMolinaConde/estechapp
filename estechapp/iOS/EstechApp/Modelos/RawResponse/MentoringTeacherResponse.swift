//
//  MentoringTeacherResponse.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 17/05/24.
//

import Foundation

struct MentoringTeacherResponse: Codable {
    let id: Int
    let roomId: Int?
    let date: String?
    let status: String?
    let teacherId: Int
    let studentId: Int
}
