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

class FetchEpisodesActionMockDelegate: ActionDelegate {
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        var json = JSON(
            [
                [
                    "name": "Getting Started",
                    "number": 1,
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Shourtest Route",
                    "number": 2,
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Loops and Repetitions",
                    "number": 3,
                    "url" : "http://localhost:8000/"
                ],
                [
                    "name": "Loops with Conditions",
                    "number": 4,
                    "url" : "http://localhost:8000/"
                ]
            ])
        
        
        var data = json.rawData()
        processData(data!)
        callback()
    }
    
}