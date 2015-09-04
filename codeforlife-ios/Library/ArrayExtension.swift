//
//  ArrayExtension.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func appendIfNotNil(newElement: T?) {
        if let newElement = newElement {
            append(newElement)
        }
    }
    
    func foreach(closure: (T) -> Void) {
        for element in self {
            closure(element)
        }
    }
    
}