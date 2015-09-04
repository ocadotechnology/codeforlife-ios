//
//  GameViewInteractionHandler.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import WebKit

class GameViewInteractionHandler: NSObject, WKScriptMessageHandler {
    
    let gvcDelegate: GameViewControllerDelegate
    let animationFactory: AnimationFactory
    weak var gameViewController: GameViewController? {
        didSet { gvcDelegate.setGameViewController(gameViewController) }
    }
    
    // AnimationQueues is a 2D array with lists of animations(ie [[Animation]])
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        println("[GameViewInteractionController] Receiving Packages...")
        if let result = message.body as? NSString,
                data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let queues = JSON(data: data)
            if let queuesArray = queues.array {
                var animationQueues = [[Animation]]()
                println("[GameViewInteractionController] Processing data to animation queue")
                for queue in queuesArray {
                    if let queueArray = queue.array {
                        var animationQueue = convertToAnimationQueue(queueArray)
                        animationQueues.append(animationQueue)
                    }
                }
                gvcDelegate.executeAnimation(animationQueues, completion: nil)
            }
        }
        
    }
    
    private func convertToAnimationQueue(queue: [JSON]) -> [Animation] {
        var animations = [Animation]()
        for object in queue {
            if let animation = animationFactory.createAction(object) {
                animations.append(animation)
            }
        }
        return animations
    }
    
    override init() {
        gvcDelegate = GameViewControllerDelegate()
        animationFactory = AnimationFactory(animationDelegate: gvcDelegate)
        super.init()
    }
    

    
}
