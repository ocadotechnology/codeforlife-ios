//
//  FetchLevelsActionDevDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FetchLevelsActionDevDeletage : ActionDelegate {
    
    var url: String
    var method: Alamofire.Method
    
    init(url: String) {
        self.url = url
        self.method = Alamofire.Method.GET
    }
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        
        Alamofire.request(method, url)
            .authenticate(user: "trial", password: "cabbage")
            .responseJSON { (req, res, json, error) in
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