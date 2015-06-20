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
    var delegate = ActionDelegate()
    
    init(url : String, httpMethod: Alamofire.Method)
    {
        self.url = url
        self.method = httpMethod
    }
    
    func prepareHTTPRequest() -> Request {
        return Alamofire.request(method, url)
    }
    
    func execute()
    {
        var request = prepareHTTPRequest()
        self.delegate.execute(request, processData: processData)
    }
    
    // Shows Request Detail in console
    // Never call this before REQUEST is initialized
    func showRequestDetails() {
        println("===Request Detail===")
        println("  -- URL        : \(url)")
        println("  -- Method     : \(method)")
    }
    
    func processData(data: NSData) {
        NSException(name: "Impelement processData for \(self)", reason: "" , userInfo: nil).raise()
    }
    
    func switchToMock() -> Action? {
        return nil
    }
    
}
