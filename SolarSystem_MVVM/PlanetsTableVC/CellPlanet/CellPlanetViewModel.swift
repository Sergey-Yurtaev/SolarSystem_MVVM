//
//  CellPlanetViewModel.swift
//  Planets(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 15.08.2022.
//

import Foundation

protocol CellPlanetViewModalProtocol {
    
    var namePlanet: String { get }
    
    init(planet: Planet)
}

final class CellPlanetViewModal: CellPlanetViewModalProtocol {

    var namePlanet: String {
        positionAndNamePlanet()
    }
    
    private let planet: Planet
    
    required init(planet: Planet) {
        self.planet = planet
    }
    
    func positionAndNamePlanet() -> String {
        var positionAndNamePlanet = ""
        if planet.name == "Sun" {
            positionAndNamePlanet = "☀️ \(planet.name ?? "")"
        } else if planet.name == "Earth" {
            positionAndNamePlanet = "\(planet.position ?? ""). \(planet.name ?? "") 🌏"
        } else {
            positionAndNamePlanet = "\(planet.position ?? ""). \(planet.name ?? "")"
        }
        return positionAndNamePlanet
    }
    
}
