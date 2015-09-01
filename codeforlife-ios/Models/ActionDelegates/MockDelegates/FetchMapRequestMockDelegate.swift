//
//  FetchMapActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchMapRequestMockDelegate : RequestDelegate {
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        
/*
        var json = JSON(
            [
                "origin": "{\"coordinate\":[6, 1], \"direction\":\"S\"}",
                "destinations": "[[2, 7], [7, 7], [8, 5], [8, 1]]",
                "path": "[{\"coordinate\":[6,1],\"connectedNodes\":[4]},{\"coordinate\":[3,0],\"connectedNodes\":[49,2]},{\"coordinate\":[4,0],\"connectedNodes\":[1,3]},{\"coordinate\":[5,0],\"connectedNodes\":[2,4]},{\"coordinate\":[6,0],\"connectedNodes\":[3,0,5]},{\"coordinate\":[7,0],\"connectedNodes\":[4,6]},{\"coordinate\":[8,0],\"connectedNodes\":[5,11]},{\"coordinate\":[1,0],\"connectedNodes\":[8,49]},{\"coordinate\":[1,1],\"connectedNodes\":[9,7]},{\"coordinate\":[2,1],\"connectedNodes\":[8,10]},{\"coordinate\":[3,1],\"connectedNodes\":[9,38]},{\"coordinate\":[8,1],\"connectedNodes\":[12,6]},{\"coordinate\":[8,2],\"connectedNodes\":[13,11]},{\"coordinate\":[8,3],\"connectedNodes\":[14,12]},{\"coordinate\":[8,4],\"connectedNodes\":[15,13]},{\"coordinate\":[8,5],\"connectedNodes\":[16,14]},{\"coordinate\":[8,6],\"connectedNodes\":[17,15]},{\"coordinate\":[7,6],\"connectedNodes\":[43,18,16,42]},{\"coordinate\":[7,7],\"connectedNodes\":[19,17]},{\"coordinate\":[6,7],\"connectedNodes\":[20,18]},{\"coordinate\":[5,7],\"connectedNodes\":[21,19]},{\"coordinate\":[4,7],\"connectedNodes\":[22,20]},{\"coordinate\":[3,7],\"connectedNodes\":[30,21]},{\"coordinate\":[2,6],\"connectedNodes\":[24,30,48,29]},{\"coordinate\":[1,6],\"connectedNodes\":[25,23]},{\"coordinate\":[0,6],\"connectedNodes\":[24,26]},{\"coordinate\":[0,5],\"connectedNodes\":[25,27]},{\"coordinate\":[0,4],\"connectedNodes\":[26,31]},{\"coordinate\":[2,4],\"connectedNodes\":[29,34,33]},{\"coordinate\":[2,5],\"connectedNodes\":[23,28]},{\"coordinate\":[2,7],\"connectedNodes\":[22,23]},{\"coordinate\":[0,3],\"connectedNodes\":[27,32]},{\"coordinate\":[1,3],\"connectedNodes\":[31,33]},{\"coordinate\":[2,3],\"connectedNodes\":[32,28]},{\"coordinate\":[3,4],\"connectedNodes\":[28,35]},{\"coordinate\":[4,4],\"connectedNodes\":[34,39,36]},{\"coordinate\":[4,3],\"connectedNodes\":[35,37]},{\"coordinate\":[4,2],\"connectedNodes\":[36,38]},{\"coordinate\":[4,1],\"connectedNodes\":[10,37]},{\"coordinate\":[5,4],\"connectedNodes\":[35,40]},{\"coordinate\":[6,4],\"connectedNodes\":[39,41]},{\"coordinate\":[7,4],\"connectedNodes\":[40,42]},{\"coordinate\":[7,5],\"connectedNodes\":[17,41]},{\"coordinate\":[6,6],\"connectedNodes\":[44,17]},{\"coordinate\":[5,6],\"connectedNodes\":[43,45]},{\"coordinate\":[5,5],\"connectedNodes\":[46,44]},{\"coordinate\":[4,5],\"connectedNodes\":[47,45]},{\"coordinate\":[4,6],\"connectedNodes\":[48,46]},{\"coordinate\":[3,6],\"connectedNodes\":[23,47]},{\"coordinate\":[2,0],\"connectedNodes\":[7,1]}]",
                "traffic_lights": "[]",
                "max_fuel": 50,
                "theme": "http://localhost:8000/rapidrouter/api/themes/1/",
                "leveldecor_set":
                    [
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/203/",
                            "x": 875,
                            "y": 86,
                            "decorName": "bush",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/204/",
                            "x": 874,
                            "y": 448,
                            "decorName": "bush",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/205/",
                            "x": 775,
                            "y": 688,
                            "decorName": "bush",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/206/",
                            "x": 119,
                            "y": 512,
                            "decorName": "tree2",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/207/",
                            "x": 93,
                            "y": 397,
                            "decorName": "tree2",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/208/",
                            "x": 296,
                            "y": 289,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/209/",
                            "x": 487,
                            "y": 203,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/210/",
                            "x": 231,
                            "y": 189,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/211/",
                            "x": 73,
                            "y": 172,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/212/",
                            "x": 604,
                            "y": 300,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/213/",
                            "x": 672,
                            "y": 194,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/214/",
                            "x": 516,
                            "y": 286,
                            "decorName": "tree1",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/215/",
                            "x": 587,
                            "y": 211,
                            "decorName": "tree2",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ],
                        [
                            "url": "http://localhost:8000/rapidrouter/api/leveldecors/216/",
                            "x": 700,
                            "y": 283,
                            "decorName": "tree2",
                            "level": "http://localhost:8000/rapidrouter/api/levels/18/"
                        ]
                ]
            ])
        
        var data = json.rawData()
        processData(data!)
*/
        callback()
    }

}