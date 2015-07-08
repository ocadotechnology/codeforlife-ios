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
}

class Action : ActionProtocol {
    
    var mode = Mode
    var params = [String: String]()
    var delegate : ActionDelegate
    var mockDelegate: ActionDelegate
    var devUrl: String?
    
    init(devUrl: String?, delegate: ActionDelegate, mockDelegate: ActionDelegate) {
        self.devUrl = devUrl
        self.delegate = delegate
        self.mockDelegate = mockDelegate
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
        self.delegate = mockDelegate
        return self
    }
    
    final func switchToDev() -> Action {
        self.mode = DevMode
        self.delegate = APIActionDelegate(url: devUrl, method: Alamofire.Method.GET)
        return self
    }
    
    // Every ACTION must implement this to handle JSON processing
    func processData(data: NSData) {
        fatalError("Implement processData() for \(self)")
    }
    
}
