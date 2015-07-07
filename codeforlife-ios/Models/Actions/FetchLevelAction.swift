//
//  FetchLevelAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FetchLevelAction : Action, ActionProtocol
{
    
    var gameViewController: GameViewController
    var url: String
    
    init( _ gameViewController: GameViewController, _ url: String? = nil) {
        self.gameViewController = gameViewController
        self.url = url ?? gameViewController.level!.url
        super.init(delegate: APIActionDelegate(url: self.url, method: Alamofire.Method.GET))
    }
    
    override func processData(data: NSData) {
            
        let json = JSON(data: data)
        if let description = json["description"].string,
            hint = json["hint"].string,
            blocklyEnabled = json["blocklyEnabled"].bool,
            pythonEnabled = json["pythonEnabled"].bool,
            pythonViewEnabled = json["pythonViewEnabled"].bool,
            originString = json["origin"].string,
            destinationsString = json["destinations"].string,
            pathString = json["path"].string,
            level = gameViewController.level {
                level.description = description
                level.hint = hint
                level.blocklyEnabled = blocklyEnabled
                level.pythonViewEnabled = pythonViewEnabled
                level.pythonEnabled = pythonEnabled
                
                if let originDataFromString = originString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                    let originJson = JSON(data: originDataFromString)
                    if let originCoordinates = originJson["coordinate"].array,
                        originDirection = originJson["direction"].string {
                            var direction: CompassDirection
                            switch originDirection {
                            case "N": direction = CompassDirection.N
                            case "E": direction = CompassDirection.E
                            case "S": direction = CompassDirection.S
                            case "W": direction = CompassDirection.W
                            default:
                                direction = CompassDirection.S
                            }
                            level.origin = Origin(
                                originCoordinates[0].int!,
                                originCoordinates[1].int!,
                                direction)
                    }
                }
                
                if let pathDataFromString = pathString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
                    pathArray = JSON(data: pathDataFromString).array {
                    var nodes = [Node]()
                    for elem in pathArray {
                        if let coordinates = elem["coordinate"].array {
                            var node = Node(Coordinates(coordinates[0].int!, coordinates[1].int!))
                            nodes.append(node)
                        }
                    }
                    
                    var i = 0
                    for elem in pathArray {
                        if let connectedNodes = elem["connectedNodes"].array {
                            for index in connectedNodes {
                                nodes[i].addConnectedNode(nodes[index.int!])
                            }
                        }
                        i++
                    }
                    level.path = nodes
                }
                
                if let destinationsDataFromString = destinationsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                    let destinationsJson = JSON(data: destinationsDataFromString)
                    if let destinations = destinationsJson.array {
                        for destination in destinations {
                            for node in level.path {
                                if node.coordinates == Coordinates(destination[0].int!, destination[1].int!) {
                                    node.isDestination = true
                                }
                            }
                        }
                    }
                }
    
            }

    }
    
    override func switchToDev() -> Action {
        self.mode = DevMode
        return self
    }
    
    override func switchToMock() -> Action {
        self.mode = MockMode
        let devUrl = "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/levels/13/"
        self.delegate = APIActionDelegate(url: devUrl, method: Alamofire.Method.GET)
        return self
    }
    
}