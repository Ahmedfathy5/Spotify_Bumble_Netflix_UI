//
//  Product.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 14/04/2024.
//

import Foundation


struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int?
}

struct Product: Codable,Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    let recentlyAdded: Bool = {
        Int.random(in: 1...4) == 1
    } ()
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Ahmed Fathy",
            description: "A computer science student seeking to be an ios engineer.",
            price: 999,
            discountPercentage: 12355,
            rating: 10,
            stock: 10,
            brand: "African Boy",
            category: "Original",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage,Constants.randomImage,Constants.randomImage,Constants.randomImage,Constants.randomImage]
        )
        
    }
    
}

struct ProductRow : Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
