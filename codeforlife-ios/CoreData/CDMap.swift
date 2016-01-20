//
//  CDMap.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 27/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import SwiftyJSON

@objc(CDMap)
class CDMap: NSManagedObject {

    @NSManaged var url: String
    @NSManaged var jsonData: NSData
    
    class func createInManagedObjectContext(url: String, jsonData: NSData) -> CDMap {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("CDMap", inManagedObjectContext: managedObjectContext!) as! CDMap
        newItem.url = url
        newItem.jsonData = jsonData
        return newItem
    }
    
    class func fetchResults() -> [CDMap] {
        let fetchRequest = NSFetchRequest(entityName: "CDMap")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchResults = try! managedObjectContext?.executeFetchRequest(fetchRequest) as? [CDMap]
        return fetchResults ?? []
    }
    
    class func save() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        try! managedObjectContext?.save()
//        if error != nil { print("Cannot save maps") }
    }
    
    class func removeAllEntries() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        for map in CDMap.fetchResults() {
            managedObjectContext?.deleteObject(map)
        }
    }
    
    func toMap(delegate: GameViewControllerDelegate?) -> MapScene? {
        let json = JSON(data: jsonData)
        if let originString = json["origin"].string,
            destinationsString = json["destinations"].string,
            pathString = json["path"].string,
            levelDecorSet = json["leveldecor_set"].array {
                let nodes = convertToNodes(pathString)
                let destinations = convertToDestinations(destinationsString, nodes: nodes)
                let decorations = convertToDecorations(levelDecorSet)
                if let origin = convertToOrigin(originString) {
                    return MapScene(delegate: delegate, width: 10, height: 10, origin: origin, nodes: nodes, destination: destinations, decorations: decorations)
                }
        }
        return nil
    }
    
    private func convertToOrigin(originString: String) -> Origin? {
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
                    return Origin(originCoordinates[0].int!, originCoordinates[1].int!,direction)
            }
        }
        return nil
    }
    
    private func convertToNodes(pathString: String) -> [Node] {
        var nodes = [Node]()
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
        return nodes
    }
    
    private func convertToDestinations(destinationsString: String, nodes: [Node]) -> [Destination] {
        var destinations = [Destination]()
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
        return destinations
    }

    private func convertToDecorations(levelDecorSet: [JSON]) -> [Decoration] {
        var decorations = [Decoration]()
        for decoration in levelDecorSet {
            if let x = decoration["x"].int,
                y = decoration["y"].int,
                decorName = decoration["decorName"].string {
                    var posX = CGFloat(x) * GameMapConfig.DecorationRatio.x + GameMapConfig.GridSize.width  * GameMapConfig.DecorationOffsetRatio.x + GameMapConfig.MapOffset.x
                    var posY = CGFloat(y) * GameMapConfig.DecorationRatio.y + GameMapConfig.GridSize.height * GameMapConfig.DecorationOffsetRatio.y + GameMapConfig.MapOffset.y
                    decorations.append(Decoration(imageNamed: decorName, position: CGPointMake(posX, posY)))
            }
        }
        return decorations
    }

}
