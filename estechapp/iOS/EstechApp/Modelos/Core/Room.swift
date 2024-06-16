//
//  Room.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 14/06/24.
//

import Foundation

struct Room {
    let id: Int
    let roomId: Int
    
    var name: String {
        "Aula #\(roomId)"
    }
}
