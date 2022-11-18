//
//  CarInfo.swift
//  AppCarros
//
//  Created by Igor Fernandes on 18/11/22.
//

import Foundation

struct CarInfo: Codable {
    let id: Int
    let descricao: String
    let latitude, longitude: String?
    let nome, tipo: String
    let urlFoto: String?
    let urlVideo: String?
}
