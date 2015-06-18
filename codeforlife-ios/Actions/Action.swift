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

protocol ActionProtocol {
    func processData(data: NSDictionary)
    func switchToMock() -> Action?
}

class Action : ActionProtocol {
    
    var url: String?
    var httpMethod: String?
    var params = [String: String]()
    var delegate = ActionDelegate()
    
    init(url : String, httpMethod: String)
    {
        self.url = url
        self.httpMethod = httpMethod
    }
    
    func prepareHTTPRequest() -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: NSURL(string: self.url!)!)
        request.HTTPMethod = self.httpMethod!
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var err: NSError?
        if request.HTTPMethod == "POST" {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        }
        return request
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
        println("  -- Method     : \(httpMethod)")
    }
    
    func processData(data: NSDictionary) {
        NSException(name: "Impelement processData for \(self)", reason: "" , userInfo: nil).raise()
    }
    
    func switchToMock() -> Action? {
        return nil
    }
    
}
