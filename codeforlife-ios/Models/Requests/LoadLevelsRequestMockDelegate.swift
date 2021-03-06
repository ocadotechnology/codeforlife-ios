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

class LoadLevelsRequestMockDelegate: RequestDelegate
{
    
    func execute(processData: (NSData -> Void), callback: (() -> Void)?) {
        let json = JSON(
            [
                "level_set":
                    [
                        [
                            "name": "18",
                            "title": "Can you help the van get to the house?",
                            "url": "http://localhost:8000/"
                        ]
                    ]
            ])
        
        let data = try! json.rawData()
        processData(data)
        callback?()
    }
}