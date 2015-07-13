//
//  FetchLevelActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 04/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

class FetchLevelActionMockDelegate: ActionDelegate {

    func execute(processData: (NSData -> Void), callback: () -> Void) {
        var json = JSON(
            [
                "name": "18",
                "title": "This one is quite a tangle. ",
                "description": "<b>This one is quite a tangle. </b><br><br>Practise your new skills on this road by getting the van to <b>Deliver</b> to each of the houses. ",
                "hint": "To make sure the van takes the shortest route, first turn left. <br><br> Use the <b>Deliver</b> block every time the van gets to a house. ",
                "levelblock_set": "http://localhost:8000/rapidrouter/api/levels/18/blocks/",
                "map": "http://localhost:8000/rapidrouter/api/levels/18/map/",
                "blocklyEnabled": true,
                "pythonEnabled": false,
                "pythonViewEnabled": false

            ])
        
        var data = json.rawData()
        processData(data!)
        callback()
    }
    
}