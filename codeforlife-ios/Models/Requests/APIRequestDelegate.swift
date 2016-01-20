//
//  APIActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIRequestDelegate : RequestDelegate {
    
    let url: String
    let method: Alamofire.Method
    
    init(url: String? ,method: Alamofire.Method) {
        self.url = url ?? "Cannot Fetch URL"
        self.method = method
    }
    
    func execute(processData: (NSData -> Void), callback: (() -> Void)?) {
        Alamofire
            .request(method, url)
            .authenticate(user: "trial", password: "cabbage")
            .responseJSON { response in
//                if(error != nil) {
//                    NSLog("Error: \(response. error)")
//                    println(req)
//                    println(res)
//                }
//                else if json != nil {
                if let data = response.data {
                    processData(data)
                }
//                }
                callback?()
        }
    }
    
}
