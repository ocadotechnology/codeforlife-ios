//
//  GameMapViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit

class GameMapViewController: SubGameViewController {
    
    var skView: GameMapView?
    var map: Map?
    
    override var frame: CGRect {
        get {
            return CGRect(
                x: self.gameViewController!.view.frame.width * (1 - self.gameViewController!.webViewPortion) + self.gameViewController!.webViewOffset,
                y: self.gameViewController!.webViewOffset,
                width: self.gameViewController!.view.frame.width * self.gameViewController!.webViewPortion - 2 * self.gameViewController!.webViewOffset,
                height: self.gameViewController!.view.frame.height - 2 * self.gameViewController!.webViewOffset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = GameMapView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.addSubview(skView!)
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        skView?.ignoresSiblingOrder = true
        
        let (origin, nodes, destinations) = test1()
        map = Map(width: 5, height: 5, origin: origin, nodes: nodes, destination: destinations)
        
        map?.size = frame.size
        map!.scaleMode = .ResizeFill
        skView?.presentScene(map!)
        map?.draw()
    }
    
    func test1() -> (Origin, [Node], [Node]) {
        var nodes = [Node]()
        var origin = Origin(0, 5, CompassDirection.E)
        var destinations = [Node]()
        
        nodes.append(Node(Coordinates(0,5)))
        nodes.append(Node(Coordinates(1,5)))
        nodes.append(Node(Coordinates(2,5)))
        nodes.append(Node(Coordinates(2,4)))
        nodes.append(Node(Coordinates(2,3)))
        nodes.append(Node(Coordinates(2,2)))
        nodes.append(Node(Coordinates(3,2)))
        nodes.append(Node(Coordinates(4,2)))
        nodes.append(Node(Coordinates(4,3)))
        nodes.append(Node(Coordinates(4,4)))
        nodes.append(Node(Coordinates(5,4)))
        nodes.append(Node(Coordinates(6,4)))
        
        var destination = Node(Coordinates(6,5))
        destinations.append(destination)
        nodes.append(destination)
        
        for index in 1 ..< nodes.count {
            nodes[index-1].addConnectedNodeWithBackLink(nodes[index])
        }
        return (origin, nodes, destinations)
    }

}
