//
//  Products.swift
//  Hausaufgaben3monat6
//
//  Created by Maksat Edil on 17/1/24.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
}
