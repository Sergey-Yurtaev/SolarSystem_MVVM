//
//  DetailsViewModel.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 15.08.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    
    var planetName: String { get }
    var velocity: String { get }
    var distance: String { get }
    var description: String { get }
    var imageData: Data? { get }
    var isFavorite: Box<Bool> { get }
    var urlFullInfo: String { get }
    
    init(planet: Planet)
    
    func fetchImage(completion: @escaping() -> Void)
    func setFavoriteStatus()
    func changeFavoriteStatus()
}

class DetailsViewModel: DetailsViewModelProtocol {
    var urlFullInfo: String {
        "https://en.wikipedia.org/wiki/Solar_System"
    }
    
    var planetName: String {
        planet.name ?? "No Info"
    }
    
    var velocity: String {
        "Orbital speed - \(planet.velocity ?? "No info") km/s"
    }
    
    var distance: String {
        "Distance to the Sun - \(planet.distance ?? "No Info") million km"
    }
    
    var description: String {
        planet.description ?? "No Info"
    }
    
    var imageData: Data? {
        getImage()
    }

    var isFavorite: Box<Bool>
    
    private let planet: Planet
    
    required init(planet: Planet) {
        self.planet = planet
        isFavorite = Box(false)
    }
    
    func setFavoriteStatus() {
        isFavorite.value = DataManager.shared.loadFavoriteStatus(for: planet.name ?? "")
    }
    
    func changeFavoriteStatus() {
        isFavorite.value.toggle()
        DataManager.shared.saveFavoriteStatus(for: planet.name ?? "", with: isFavorite.value)
    }
    
    func fetchImage(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            completion()
        }
    }
    
    private func getImage() -> Data? {
        guard let imageData = ImageManager.shared.fetchImage(from: self.planet.image) else { return nil }
        return imageData
    }
}


