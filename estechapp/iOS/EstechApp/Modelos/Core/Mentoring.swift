//
//  Mentoring.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 17/05/24.
//

import Foundation

enum MentoringStatus: String {
    case approved = "APPROVED"
    case denied = "DENIED"
    case pending = "PENDING"
    case modified = "MODIFIED"
}

struct Mentoring {
    let id: Int
    let roomId: Int
    let date: Date
    let status: MentoringStatus
    let teacherId: Int
    let studentId: Int
}
