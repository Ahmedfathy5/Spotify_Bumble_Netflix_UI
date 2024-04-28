//
//  User.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 14/04/2024.
//

import Foundation




struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable,Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    var work: String {
        "Worker as some jop"
    }
    var education: String {
        "graduation as a King"
    }
    
    var aboutMe: String {
        
        "watchout you are looking to the king now 🤴🏻"
        }
    
    var basic:[UserInterst] {
        
        [
            UserInterst(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterst(iconName: "graduationcap", emoji: nil, text: education),
            UserInterst(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterst(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    
    var intersts: [UserInterst] {
        
        [
            UserInterst(iconName: nil, emoji: "🤴🏻", text: "King"),
            UserInterst(iconName: nil, emoji: "🇪🇬", text: "Regret"),
            UserInterst(iconName: nil, emoji: "❤️", text: "Love"),
            UserInterst(iconName: nil, emoji: "⚽️", text: "Football"),
        ]
    }
    
    var images: [String] {
        
        [
            "https://picsum.photos/500/600",
            "https://picsum.photos/600/500",
            "https://picsum.photos/700/700"

        ]
        
    }
    
    
    static var mock: User {
        User(
            id: 123,
            firstName: "Ahmed Elsaka",
            lastName: "Fathy",
            age: 21,
            email: "ahmedfathyios1@gmail.com",
            phone: "01204315858",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
    
}
