//
//  main.swift
//  ValueVsRefs
//
//  Created by jeongminho on 2020/06/04.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

var str = "Hello, Swift!"
var swiftGreeting = str
swiftGreeting += " How are you?"

class GreekGod {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let hecate = GreekGod(name: "Hecate")
let anotherHecate = hecate

anotherHecate.name = "AnotherHecate"

struct Pantheon {
    var chiefGod: GreekGod
}

let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
zeus.name = "Zeus Jr."

let greekPantheon = pantheon
hecate.name = "Trivia"

let athena = GreekGod(name: "Athena")

let gods = [athena, hecate, zeus]
let godsCopy = gods
gods.last?.name = "Jupiter"


var integers = IntArray()
integers.append(1)
integers.append(2)
integers.append(4)
integers.describe()

var ints = integers
ints.insert(3, at: 2)
integers.describe()



