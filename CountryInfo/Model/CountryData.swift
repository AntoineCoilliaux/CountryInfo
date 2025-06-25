//
//  CountryData.swift
//  CountryInfo
//
//  Created by Antoine Coilliaux on 25/06/2025.
//

import Foundation
struct CountryData: Codable {
    let name: Name
    let capital: [String]
    let flags: Flags
    let population: Int
}

struct Name: Codable {
    let common: String
}

struct Flags: Codable {
    let png: String
}
