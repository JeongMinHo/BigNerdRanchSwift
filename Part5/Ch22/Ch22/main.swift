//
//  main.swift
//  Ch22
//
//  Created by jeongminho on 2020/06/11.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func map<U>(_ f: (Element) -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(f(item))
        }
        return Stack<U>(items: mappedItems)
    }
}

func myMap<T,U>(_ items: [T], _ f: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(f(item))
    }
    return result
}

let strings = ["one","minho","three"]
let stringsLength = myMap(strings) { $0.count }
print(stringsLength)
