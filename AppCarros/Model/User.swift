//
//  User.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let login, nome, email: String
    let urlFoto: String
    let token: String
}
