//
//  User.swift
//  Authentication
//
//  Created by Ruslan Alekyan on 01.03.2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        fullname.components(separatedBy: " ").reduce("") { $0 + $1.prefix(1) }
    }
}
