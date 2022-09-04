//
//  DataManager.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 14.08.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults()
    private init() {}
    
    func saveFavoriteStatus(for namePlanet: String, with status: Bool) {
        userDefaults.set(status, forKey: namePlanet)
    }
    
    func loadFavoriteStatus(for namePlanet: String) -> Bool {
        userDefaults.bool(forKey: namePlanet)
    }
}
