//
//  BaseAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire

protocol ActionProtocol {
    func processData(data: NSData)
    func toMock()
    func toDev()
}

class Action : ActionProtocol {
    
    // Every ACTION must implement this to handle JSON processing
    func processData(data: NSData) {
        fatalError("Implement processData() for \(self)")
    }
    
    // Override this function when extra updates need to be performed
    func toDev() {}
    
    // Override this function when extra updates need to be performed
    func toMock() {}
    
    /***************************************************************/
    
    var params = [String: String]()
    var delegate : ActionDelegate
    var mode = Mode
    
    init(delegate: ActionDelegate) {
        self.delegate = delegate
    }
    
    final func execute(callback: () -> Void = {})
    {
        if mode == DevMode {
            self.switchToDev().delegate.execute(processData, callback: callback)
        } else if mode == MockMode {
            self.switchToMock().delegate.execute(processData, callback: callback)
        } else {
            delegate.execute(processData, callback: callback)
        }
    }
    
    final func switchToMock() -> Action {
        self.mode = MockMode
        toMock()
        return self
    }
    
    final func switchToDev() -> Action {
        self.mode = DevMode
        toDev()
        return self
    }
    

    
}
