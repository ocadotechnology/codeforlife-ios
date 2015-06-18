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

class BaseAction {
    
    var url: String?
    var httpMethod: String?
    var params = [String: String]()
    
    var jsonResult: NSDictionary? { didSet { } }
    var statusCode: Int? { didSet { showRequestDetails() } }
    
    init(url : String, httpMethod: String)
    {
        self.url = url
        self.httpMethod = httpMethod
    }
    
    private func prepareHttpRequest() -> NSMutableURLRequest {
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
        var request = prepareHttpRequest()
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) -> Void in
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            self.jsonResult = jsonResult
            if let httpResponse = response as? NSHTTPURLResponse {
                self.statusCode = httpResponse.statusCode
            }
        }
        task.resume()
        
    }
    
    // Shows Request Detail in console
    // Never call this before REQUEST is initialized
    func showRequestDetails() {
        println("===Request Detail===")
        println("  -- URL        : \(url)")
        println("  -- Method     : \(httpMethod)")
        println("  -- Status Code: \(statusCode)")
        println("  -- Data       : \(jsonResult)")
    }
    
    func processJSONData() {
        
    }
    
}
