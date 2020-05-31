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



var groceryBag = Set<String>()
groceryBag.insert("Apples")
groceryBag.insert("Oranges")
groceryBag.insert("Pineapple")

let friendsGrceryBag = Set(["Bananas","Cereal","Milk","Oranges"])
let commonGroceryBag = groceryBag.union(friendsGrceryBag)

let roomateGroceryBag = Set(["Apples","Bananas","Cereal","Toothpaste"])
let itemsToReturn = commonGroceryBag.intersection(roomateGroceryBag)

let mySecondBag = Set(["Berries","Yogurt"])
let roomatesSecondBag = Set(["Grapes", "Honey"])
let disjoint = mySecondBag.isDisjoint(with: roomatesSecondBag)

// Ch11 예선과제
let myCities = Set(["Atlanta","Chicago","Jacksonville","New York","San Francisco"])
let yourCities = Set(["Chicago","San Francisco","Jacksonville"])

let check = myCities.isSuperset(of: yourCities)

// Ch11 본선과제
var myGroceryBag: Set = ["Apples", "Oranges", "Pineapples"]
let otherFriendsGroceryBag = Set(["Bananas", "Cereal", "Milk", "Oranges"])
let otherRoommatesGroceryBag = Set(["Apples", "Bananas", "Cereal", "Toothpaste"])

myGroceryBag.formUnion(otherFriendsGroceryBag)
myGroceryBag.formIntersection(otherRoommatesGroceryBag)


// Ch12 예선과제
func greetMiddleName(fromFullName name: (first: String, middle: String?, last: String)) {
    guard let middleName = name.middle, middleName.count >= 4 else {
        print("Hey there")
        return
    }
    print("Hey \(middleName)")
}

// Ch12 본선과제
func siftBeans(fromGroceryList list: [String]) -> (beans: [String], otherGroceries: [String]) {
    var beans: [String] = []
    var otherGroceries: [String] = []
    list.forEach {
        if $0.hasSuffix("beans") {
            beans.append($0)
        } else {
            otherGroceries.append($0)
        }
    }
    return (beans, otherGroceries)
}

let result = siftBeans(fromGroceryList: ["green beans",
                                         "milk",
                                         "black beans",
                                         "pinto beans",
                                         "apples"
])

print(result.beans)
print(result.otherGroceries)
