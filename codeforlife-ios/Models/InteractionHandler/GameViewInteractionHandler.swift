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

public class GameViewInteractionHandler: NSObject, WKScriptMessageHandler {
    
    public let animationFactory: AnimationFactory
    public weak var gvcDelegate: GameViewControllerDelegate!
    
    // AnimationQueues is a 2D array with lists of animations(ie [[Animation]])
    public func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
        print("[GameViewInteractionController] Receiving Packages...")
        if let result = message.body as? NSString,
                data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let queues = JSON(data: data)
            if let queuesArray = queues.array {
                var animationQueues = [[Animation]]()
                print("[GameViewInteractionController] Processing data to animation queue")
                for queue in queuesArray {
                    if let queueArray = queue.array {
                        let animationQueue = convertToAnimationQueue(queueArray)
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
    
    public init(gameViewControllerDelegate: GameViewControllerDelegate) {
        gvcDelegate = gameViewControllerDelegate
        animationFactory = AnimationFactory(animationDelegate: gvcDelegate)
        super.init()
    }
    

    
}
