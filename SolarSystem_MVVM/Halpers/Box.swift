//
//  Box.swift
//  Planets(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 17.08.2022.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
 
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) { 
        self.listener = listener
        listener(value)
    }
}
