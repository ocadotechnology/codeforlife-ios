//
//  APIActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class APIActionDeletage : ActionDelegate, ActionDelegateProtocol {
    
    override func execute(request: NSMutableURLRequest, processData: (NSData -> Void)) {
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) -> Void in
            processData(data)
        }
        task.resume()
    }
    
}
