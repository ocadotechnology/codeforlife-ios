//
//  FetchBlockSetMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchBlockSetRequestMockDelegate: RequestDelegate {
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        var json = JSON(
            [
                //TODO
            ])
        
        
        var data = json.rawData()
        processData(data!)
        callback()
    }
    
}