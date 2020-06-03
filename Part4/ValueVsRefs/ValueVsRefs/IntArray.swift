//
//  IntArray.swift
//  ValueVsRefs
//
//  Created by jeongminho on 2020/06/04.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

struct IntArray {
    private var buffer: IntArrayBuffer
    
    init() {
        buffer = IntArrayBuffer()
    }
    
    func describe() {
        print(buffer.storage)
    }
    
    private mutating func copyIfNeeded() {
        if !isKnownUniquelyReferenced(&buffer) {
            print("Making a copy of \(buffer.storage)")
            buffer = IntArrayBuffer(buffer: buffer)
        }
    }
    
    mutating func insert(_ value: Int, at index: Int) {
        copyIfNeeded()
        buffer.storage.insert(value, at: index)
    }
    
    mutating func append(_ value: Int) {
        copyIfNeeded()
        buffer.storage.append(value)
    }
    
    mutating func remove(at index: Int) {
        copyIfNeeded()
        buffer.storage.remove(at: index)
    }
}
