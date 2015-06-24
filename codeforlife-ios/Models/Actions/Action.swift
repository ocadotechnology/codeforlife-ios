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
    func switchToMock() -> Action?
}

class Action : ActionProtocol {
    
    var url: URLStringConvertible
    var method: Alamofire.Method
    var params = [String: String]()
    var delegate : ActionDelegate?
    
    init(url : String, httpMethod: Alamofire.Method)
    {
        self.url = url
        self.method = httpMethod
    }
    
    func prepareHTTPRequest() -> Request {
        return Alamofire.request(method, url)
    }
    
    func execute(callback: () -> Void = {})
    {
        var request = prepareHTTPRequest()
        if let delegate = self.delegate {
            delegate.execute(request, processData: processData, callback: callback)
        } else {
            fatalError("Action delegate is probably nil")
        }
    }
    
    func showRequestDetails() {
        println("===Request Detail===")
        println("  -- URL        : \(url)")
        println("  -- Method     : \(method)")
    }
    
    func processData(data: NSData) {
        fatalError("Implement processData() for \(self)")
    }
    
    func switchToMock() -> Action? {
        return nil
    }
    
}
