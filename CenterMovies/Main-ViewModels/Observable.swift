//
//  Observable.swift
//  CenterMovies
//
//  Created by AnılKaramış on 12.02.2024.
//

import Foundation

class Observable <T> {
    
    // MARK: - Variables
    // The listener will update the value where it is called
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    // Listener to notify the binding method
    private var listener: ((T?) -> Void)?
    
    // MARK: - Initialization
    
    init(value: T?) {
        self.value = value
    }
    
    // MARK: - Bind function
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}

