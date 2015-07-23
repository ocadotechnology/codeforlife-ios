//
//  File.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FetchMapRequest : Request, RequestProtocol {
    
    weak var viewController: GameMapViewController?
    
    init( _ viewController: GameViewController?, _ url: String?) {
        self.viewController = viewController?.gameMapViewController
        super.init(
            devUrl: url,
            delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchMapRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        
        var origin: Origin?
        var nodes = [Node]()
        var destinations = [Destination]()
        var decorations = [Decoration]()
        
        let json = JSON(data: data)
        if let originString = json["origin"].string,
            destinationsString = json["destinations"].string,
            pathString = json["path"].string,
            levelDecorSet = json["leveldecor_set"].array {
                
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
                        origin = Origin(
                            originCoordinates[0].int!,
                            originCoordinates[1].int!,
                            direction)
                }
            }
            
            if let pathDataFromString = pathString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
                pathArray = JSON(data: pathDataFromString).array {
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
            }
            
            if let destinationsDataFromString = destinationsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let destinationsJson = JSON(data: destinationsDataFromString)
                if let destinationsArray = destinationsJson.array {
                    for destination in destinationsArray {
                        for node in nodes {
                            if node.coordinates == Coordinates(destination[0].int!, destination[1].int!) {
                                node.isDestination = true
                                destinations.append(Destination(node.coordinates))
                            }
                        }
                    }
                }
            }
             
            for decoration in levelDecorSet {
                if let x = decoration["x"].int,
                        y = decoration["y"].int,
                    decorName = decoration["decorName"].string {
                        var posX = CGFloat(x) * GameMapConfig.DecorationXRatio + GameMapConfig.GridSize.width  * GameMapConfig.DecorationXOffsetRatio + GameMapConfig.MapXOffset
                        var posY = CGFloat(y) * GameMapConfig.DecorationYRatio + GameMapConfig.GridSize.height * GameMapConfig.DecorationYOffsetRatio + GameMapConfig.MapYOffset
                        decorations.append(Decoration(imageNamed: decorName, position: CGPointMake(posX, posY)))
                }
            }
                
            if origin != nil {
                SharedContext.MainGameViewController?.gameMapViewController?.map = Map(width: 10, height: 10, origin: origin!, nodes: nodes, destination: destinations, decorations: decorations)
                
            }
        }
    }
    
//    deinit { println("FetchMapAction is being deallocated") }
    
}