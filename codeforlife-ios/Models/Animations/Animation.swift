//
//  GameViewAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class Animation {
    
    let delegate: AnimationDelegate?
    
    init(delegate: AnimationDelegate?) {
        self.delegate = delegate
    }
    
    func execute(completion: (() -> Void)? = nil) {
        fatalError("Abstract GameViewAction method called")
    }
    
    func stop() {
        delegate?.terminateAnimation(nil)
    }
    
}


