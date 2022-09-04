//
//  PlanetsViewModel.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 15.08.2022.
//

import Foundation

protocol PlanetsViewModalProtocol {
    var planets: [Planet] { get }
    func fetchPlanets(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CellPlanetViewModalProtocol?
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol?
    
}

class PlanetsViewModel: PlanetsViewModalProtocol {
    var planets: [Planet] = []
    
    func fetchPlanets(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [weak self] planets in
            var sortedPlanets = planets
            let sun = sortedPlanets.remove(at: sortedPlanets.count - 1)
            sortedPlanets.insert(sun, at: 0)
            
            self?.planets = sortedPlanets
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func numberOfRows() -> Int {
        planets.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellPlanetViewModalProtocol? {
        let planet = planets[indexPath.row]
        return CellPlanetViewModal(planet: planet)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol? {
        let planet = planets[indexPath.row]
        return DetailsViewModel(planet: planet)
    }
    
}
