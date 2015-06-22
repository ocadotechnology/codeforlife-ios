//
//  APIActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIActionDeletage : ActionDelegate {
    
    func execute(request: Request, processData: (NSData -> Void), callback: () -> Void) {
        request.responseJSON { (req, res, json, error) in
            if(error != nil) {
                NSLog("Error: \(error)")
                println(req)
                println(res)
            }
            else {
                processData(JSON(json!).rawData()!)
            }
            callback()
        }
    }
    
}
