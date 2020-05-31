//
//  main.swift
//  BigNerdRanch-3
//
//  Created by jeongminho on 2020/05/31.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

var bucketList = ["Climb Mt.Everest"]
bucketList.append("Fly hot air balloon to Fiji")
bucketList.append("Go on a walkabout")
var newItems = [
  "Find a triple rainbow",
  "Watch the Lord of the Rigns trilogy in one day"
]
bucketList += newItems
bucketList.remove(at: 2)

// Ch9 예선 과제
var toDoList = ["Take out garbage", "Pay bills", "Cross off finished items"]
print(toDoList.count)

// Ch9 본선 과제
var temp: [String] = []
for i in 0...toDoList.count-1 {
    temp.append(toDoList[toDoList.count-i-1])
}

toDoList.reverse()

// Ch9 결승 과제
var bucketIndex = bucketList.firstIndex(of: "Fly hot air balloon to Fiji") ?? 0
print(bucketIndex)


// Ch10 본선 과제
var americaStates = [
    "Los Angelas" : [30306, 30307, 30308, 30309, 30310],
    "Washington" : [30311,30312,30313,30314,30315],
    "Boston" : [30301,30302,30303,30304,30305]
]

var numberTemp = [Int]()

for number in americaStates.values {
    numberTemp += Array(number)
}
print(numberTemp)


