//
//  BaseAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

/*  This is the base class for all the actions associated
 *  with the API
 */

import Foundation
import Alamofire

protocol ActionProtocol {
    func processData(data: NSData)
    func switchToMock() -> Action
    func switchToDev() -> Action
}

class Action : ActionProtocol {
    
    var params = [String: String]()
    var delegate : ActionDelegate
    var mode = Mode
    
    init(delegate: ActionDelegate) {
        self.delegate = delegate
    }
    
    func execute(callback: () -> Void = {})
    {
        if mode == DevMode {
            self.switchToDev().delegate.execute(processData, callback: callback)
        } else if mode == MockMode {
            self.switchToMock().delegate.execute(processData, callback: callback)
        } else {
            delegate.execute(processData, callback: callback)
        }
    }
    
    func processData(data: NSData) {
        fatalError("Implement processData() for \(self)")
    }
    
    func switchToMock() -> Action {
        fatalError("Implement switchToMock()")
    }
    
    func switchToDev() -> Action {
        fatalError("Implement switchToDev()")
    }
    
}
