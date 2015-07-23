//
//  Command.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 23/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

/// Commands should avoid having direct connections with changing control mode
class Command {
    
    func execute(completion: (() -> Void)? = nil) {
        fatalError("Abstract GameViewCommand method called")
    }
    
}