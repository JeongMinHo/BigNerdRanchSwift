//
//  main.swift
//  BigNerdRanch-2
//
//  Created by jeongminho on 2020/05/31.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

//var shields = 5
//var blasterOverheating = false
//var blasterFireCount = 0
//var spaceDemonsDestroyed = 0
//
//while shields > 0 {
//    if spaceDemonsDestroyed == 500 {
//        print("You beat the game!")
//        break
//    }
//
//    if blasterOverheating {
//        print("Blasters are overheated!")
//        sleep(5)
//        print("Blasters ready to fire!")
//        sleep(1)
//        blasterOverheating = false
//        blasterFireCount = 0
//        continue
//    }
//
//    if blasterFireCount > 100 {
//        blasterOverheating = true
//        continue
//    }
//
//    print("Fire blasters!")
//    blasterFireCount += 1
//    spaceDemonsDestroyed += 1
//}
//
//// Ch6 본선과제
//for i in 1...100 {
//    if i % 3 == 0 {
//        print("FIZZ")
//    } else if i % 5 == 0 {
//        print("BUZZ")
//    } else {
//        print(i)
//    }
//}

var playground = "playground"
let start = playground.startIndex
let end = playground.index(start, offsetBy: 4)
let fifthCharacter = playground[end]
let range = start...end
let firstFive = playground[range]

var errorCodeString: String?
errorCodeString = "404"
var errorDescription: String?

if let theError = errorCodeString, let errorCodeInteger = Int(theError), errorCodeInteger == 404 {
    errorDescription = "\(errorCodeInteger + 200): resource was not found."
}

var upCaseErrorDescription = errorDescription?.uppercased()
upCaseErrorDescription?.append("Please try again")
print(upCaseErrorDescription)
