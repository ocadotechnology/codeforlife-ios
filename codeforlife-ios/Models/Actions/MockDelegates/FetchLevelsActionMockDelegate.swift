//
//  FetchLevelsActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchLevelsActionMockDelegate: ActionDelegate
{
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        var json = JSON(
            [
                "level_set":
                    [
                        [
                            "name": "1",
                            "title": "Can you help the van get to the house?",
                            "url": "http://localhost:8000/"],
                        [
                            "name": "2",
                            "title": "This time the house is further away.",
                            "url": "http://localhost:8000/"],
                        [
                            "name": "3",
                            "title": "Can you make the van turn right?",
                            "url": "http://localhost:8000/"],
                        [
                            "name": "4",
                            "title": "You are getting good at this! Let's try turning left.",
                            "url": "http://localhost:8000/"]
                    ]
            ])
        
        var data = json.rawData()
        processData(data!)
        callback()
    }
}