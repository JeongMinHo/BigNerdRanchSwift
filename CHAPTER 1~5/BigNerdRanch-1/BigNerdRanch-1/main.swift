//
//  main.swift
//  BigNerdRanch-1
//
//  Created by jeongminho on 2020/05/31.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

// Ch2 예선과제
let numberOfStoplights: Int = 4
var population: Int
population = 5422
let townName: String = "Knowhere"
let unemployment: Double = 15.0
let townDescription = "\(townName) has a population of \(population) and \(numberOfStoplights) stoplights and unemployment rate is \(unemployment)"
print(townDescription)

var message: String
var hasPostOffice: Bool = true

// Ch3 예선과제
if population < 10000 {
    message = "\(population) is a small town!"
} else if population >= 10000 && population < 50000 {
    message = "\(population) is a medium town!"
} else if population >= 50000 && population < 100000 {
    message = "\(population) is a pretty big!"
} else {
    message = "\(population) is big!"
}
 
print(message)


let y: Int8 = 120
let z = y &+ 10
print(z)



let d1 = 1.1
let d2: Double = 1.1
let f1: Float = 100.3

if d1 == d2 {
    print("d1 and d2 are the same!")
}

if d1 + 0.1 == 1.2 {
    print("d1 is 1.2!")
}

var statusCode: Int = 404
var errorString: String = "The request failed:"
switch statusCode {
case 400, 401, 403, 404:
    errorString = "There was something wrong with the request."
    fallthrough
default:
    errorString += "Please review the request and try again"
}
print(errorString)

switch statusCode {
case 100, 101:
    errorString += "Informational, \(statusCode)"
case 300...307:
    errorString += "Redirection, \(statusCode)"
case 400...417:
    errorString += "Client error:, \(statusCode)"
case let unknownCode:
    errorString = "\(unknownCode) is not a known error code"
}

// Ch5 예선 과제
let point = (x: 1, y: 4)

switch point {
case let q1 where point.x > 0 && point.y > 0:
    print("\(q1) is in quadrant 1")
case let q2 where point.x < 0 && point.y > 0:
    print("\(q2) is in quadrant 2")
case let q3 where point.x < 0 && point.y > 0:
    print("\(q3) is in quadrant 3")
case let q4 where point.x > 0 && point.y > 0:
    print("\(q4) is in quadrant 4")
case (_, 0):
    print("\(point) sits on the x-axis")
case (0, _):
    print("\(point) sits on the y-axis")
default:
    print("Case not covered.")
}

// // Ch5 본선 과제
let age = 25

if case 18...35 = age, age > 21, age < 30 {
  print("Cool")
}
