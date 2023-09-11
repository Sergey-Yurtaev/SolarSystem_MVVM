//
//  NetworkManager.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 12.08.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let planetsURL = "https://raw.githubusercontent.com/Lazzaro83/Solar-System/master/planets.json"
    private init() {}
    
    func fetchData(with complition: @escaping ([Planet]) -> Void) {
        guard let url = URL(string: planetsURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data else { return }
            
            do {
                let planets = try JSONDecoder().decode([Planet].self, from: data)
                complition(planets)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
}

final class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let url else { return nil }
        guard let imageURL = URL(string: url) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }
}
