//
//  BaseAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    func processData(data: NSData)
}

class Request: RequestProtocol {
    
    var mode = Mode
    var params = [String: String]()
    var delegate : RequestDelegate
    var mockDelegate: RequestDelegate
    var devUrl: String?
    
    init(devUrl: String?, delegate: RequestDelegate, mockDelegate: RequestDelegate) {
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
    
    final func switchToMock() -> Request {
        self.mode = MockMode
        self.delegate = mockDelegate
        return self
    }
    
    final func switchToDev() -> Request {
        self.mode = DevMode
        self.delegate = APIRequestDelegate(url: devUrl, method: Alamofire.Method.GET)
        return self
    }
    
    // Every ACTION must implement this to handle JSON processing
    func processData(data: NSData) {
        fatalError("Implement processData() for \(self)")
    }
    
}
