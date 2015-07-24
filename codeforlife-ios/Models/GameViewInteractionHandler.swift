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

// WKUserContentController retains its message handler causing a retain cycle,
// one of the solution to this problem is to make the actual WKScriptMessageHandler
// a weak var
class InteractionHandler: NSObject, WKScriptMessageHandler {
    
    weak var delegate: WKScriptMessageHandler?
    init(delegate: WKScriptMessageHandler?) {
        self.delegate = delegate
        super.init()
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        self.delegate?.userContentController(userContentController, didReceiveScriptMessage: message)
    }
    
}

class GameViewInteractionHandler: NSObject, WKScriptMessageHandler {

    unowned var gameViewController: GameViewController
    var animationFactory = AnimationFactory()
    
    init(_ gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    // AnimationQueues is a 2D array with lists of animations(ie [[Animation]])
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){

        if let result = message.body as? NSString,
                data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let queues = JSON(data: data)
            if let queuesArray = queues.array {
                var animationQueues = [[Animation]]()
                for queue in queuesArray {
                    if let queueArray = queue.array {
                        var animationQueue = convertToAnimationQueue(queueArray)
                        animationQueues.append(animationQueue)
                    }
                }
                SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.executeAnimations(animationQueues)
            }
        }
        
    }
    
    private func convertToAnimationQueue(queue: [JSON]) -> [Animation] {
        var animations = [Animation]()
        for object in queue {
            if let animation = animationFactory.createAnimation(object) {
                animations.append(animation)
            }
        }
        return animations
    }
    

    
}
