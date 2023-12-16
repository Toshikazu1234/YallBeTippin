//
//  Api.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import Foundation

class Api {
    static let shared = Api()
    private init() {}
    
    func fetchMenu() -> [MenuItem] {
        return [
            MenuItem(name: "Burger", price: 12.5, img: "burger"),
            MenuItem(name: "Chow mein", price: 13, img: "chowMein"),
            MenuItem(name: "Dumplings", price: 7, img: "dumplings"),
            MenuItem(name: "Fried chicken", price: 14.5, img: "friedChicken"),
            MenuItem(name: "Pizza", price: 6, img: "pizza"),
            MenuItem(name: "Spaghetti", price: 13.5, img: "spaghetti"),
            MenuItem(name: "Steak", price: 16, img: "steak"),
            MenuItem(name: "Sushi", price: 8, img: "sushi")
        ]
    }
}
