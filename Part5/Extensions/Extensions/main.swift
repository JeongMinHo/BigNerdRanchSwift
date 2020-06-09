//
//  main.swift
//  Extensions
//
//  Created by jeongminho on 2020/06/10.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

typealias Velocity = Double

extension Velocity {
    var kph: Velocity { return self * 1.60934 }
    var mph: Velocity { return self }
}

protocol Vehicle {
    var topSpeed: Velocity { get }
    var numberOfDoors: Int { get }
    var hasFlatbed: Bool { get }
}

struct Car {
    let make: String
    let model: String
    let year: Int
    let color: String
    let nickname: String
    var gasLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0 , "New value must be between 0 and 1.")
        }
    }
}

extension Car: Vehicle {
    var topSpeed: Velocity { return 100 }
    var numberOfDoors: Int { return 4 }
    var hasFlatbed: Bool { return false }
}

extension Car {
    init(make: String, model: String, year: Int) {
        self.init(make: make, model: model, year: year, color: "Black", nickname: "N", gasLevel: 1.0)
    }
}

extension Car {
    enum Kind {
        case coupe, sedan
    }
    
    var kind: Kind {
        if numberOfDoors == 2 {
            return .coupe
        } else {
            return .sedan
        }
    }
}

var c = Car(make: "Ford", model: "Fusion", year: 2013)

extension Car {
    mutating func emptyGas(by amount: Double) {
        precondition(amount <= 1 && amount > 0 , "Amount to remove must be between 0 and 1.")
        gasLevel -= amount
    }
    
    mutating func fillGas() {
        gasLevel = 1.0
    }
}

c.emptyGas(by: 0.3)

// Ch21 예선
extension Int {
    var timesFive: Int { return self * 5 }
}


