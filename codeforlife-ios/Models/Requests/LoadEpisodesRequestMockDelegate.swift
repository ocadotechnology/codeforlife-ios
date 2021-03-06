//
//  FetchEpisodesActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class LoadEpisodesRequestMockDelegate: RequestDelegate {
    
    func execute(processData: (NSData -> Void), callback: (() -> Void)?) {
        let json = JSON(
            [
                [
                    "name": "Getting Started",
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Shourtest Route",
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Loops and Repetitions",
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Loops with Conditions",
                    "url" : "http://localhost:8000/"
                ]
            ])
        
        
        let data = try! json.rawData()
        processData(data)
        callback?()
    }
    
}