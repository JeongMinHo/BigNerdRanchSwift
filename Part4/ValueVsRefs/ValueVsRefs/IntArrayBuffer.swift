//
//  IntArrayBuffer.swift
//  ValueVsRefs
//
//  Created by jeongminho on 2020/06/04.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

class IntArrayBuffer {
    var storage: [Int]
    
    init() {
        storage = []
    }
    
    init(buffer: IntArrayBuffer) {
        storage = buffer.storage
    }
}

