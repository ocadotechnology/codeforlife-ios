//
//  ActionFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 22/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import SpriteKit

class GameViewControllerDelegate: AnimationDelegate, MessageViewControllerDelegate, GameViewInteractionHandlerDelegate, MapSceneDelegate, GameMenuViewControllerDelegate {
    
     private weak var gameViewController: GameViewController?
     private weak var gameMenuViewController: GameMenuViewController?
     private weak var blocklyViewController: BlockTableViewController?
     private weak var gameMapViewController: GameMapViewController?
    
    func setGameViewController(gameViewController: GameViewController?) {
        self.gameViewController = gameViewController
    }
    
    func setGameMenuViewController(gameMenuViewController: GameMenuViewController?) {
        self.gameMenuViewController = gameMenuViewController
    }
    
    func setBlocklyViewController(blocklyViewController: BlockTableViewController?) {
        self.blocklyViewController = blocklyViewController
    }
    
    func setGameMapViewController(gameMapViewController: GameMapViewController?) {
        self.gameMapViewController = gameMapViewController
    }
    
    func switchControlMode(controlMode: GameMenuViewController.ControlMode, completion: (() -> Void)?) {
        gameMenuViewController?.controlMode = controlMode
        completion?()
    }
    
    func clear(completion: (() -> Void)?) {
        blocklyViewController?.clearBlocks()
        blocklyViewController?.resetHighlightCellVariables()
        gameMapViewController?.mapScene?.resetMap()
        gameMapViewController?.mapScene?.van.reset()
        completion?()
    }
    
    func help(completion: (() -> Void)?) {
        let controller = MessageViewController(nil, delegate: self)
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = HelpMessage(
            context: gameViewController!.level!.hint,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
    
    func mute(completion: (() -> Void)?) {
        if let viewController = gameMenuViewController {
            viewController.muted = !viewController.muted
        }
        completion?()
    }
    
    func play(completion: (() -> Void)?) {
        // Native UI Update
        gameMapViewController?.mapScene?.resetMap()
        resetAnimation(nil)
        gameMenuViewController?.clearButton.enabled = false
        
        // Submit Blocks and retrieve Animations
        gameMapViewController?.mapScene?.van.reset()
        blocklyViewController?.submitBlocks()
        completion?()
    }
    
    func displayPregameMessage(completion: (() -> Void)?) {
        let controller = MessageViewController(nil, delegate: self)
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        if let level = gameViewController?.level {
            controller.message = PreGameMessage(
                title: "Level \(level.name)",
                context: level.levelDescription,
                action: {
                    controller.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        completion?()
    }
    
    func resetAnimation(completion: (() -> Void)?) {
        gameMapViewController?.animationHandler?.removeAllAnimations()
    }
    
    func loadLevel(completion: (() -> Void)?) {
        if let urlStr = gameViewController?.level?.webViewUrl {
            var url = NSURL(string: urlStr);
            var request = NSURLRequest(URL: url!);
            gameViewController?.webView.loadRequest(request)
        }
        completion?()
    }
    
    func highlightCorrectBlock(blockId: Int) {
        blocklyViewController?.highlightRow(blockId)
    }
    
    func highlightIncorrectBLock(blockId: Int) {
        blocklyViewController?.highlightIncorrectBlockly(blockId)
    }
    
    func playSound(gameSound: GameSound, waitForCompletion: Bool, completion: (() -> Void)?) {
        gameMapViewController?.mapScene?.van.runAction(SKAction.playSoundFileNamed(gameSound.rawValue, waitForCompletion: waitForCompletion)) {
            completion?()
        }
    }
    
    func deliver(destinationId: Int, completion: (() -> Void)?) {
        gameMapViewController?.mapScene?.destinations[destinationId].visited = true
        completion?()
    }
    
    func vanMoveForward(completion: (() -> Void)?) {
        gameMapViewController?.mapScene?.van.moveForward(animated: true, completion: completion)
    }
    
    func vanCrashForward(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.moveForward(animated: true, completion: {
            [weak van] in
            van?.crash(completion)
            })
    }
    
    func vanStartEngine(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.engineStarted = true
        completion?()
    }
    
    func vanStopEngine(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.engineStarted = false
        completion?()
    }
    
    func vanTurnLeft(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.turnLeft(animated: true, completion: completion)
    }
    
    func vanCrashLeft(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.turnLeft(animated: true, completion: {
            [weak van] in
            van?.crash(completion)
        })
        
    }
    
    func vanTurnRight(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.turnRight(animated: true, completion: completion)
    }
    
    func vanCrashRight(completion: (() -> Void)?) {
        let van = gameMapViewController?.mapScene?.van
        van?.turnRight(animated: true, completion: {
            [weak van] in
            van?.crash(completion)
        })
    }
    
    func winPopup(message: String, _ pathScore: Float, _ maxPathScore: Int, _ instrScore: Float, _ maxInstrScore: Int, completion: (() -> Void)?) {
        let controller = MessageViewController(nil, delegate: self)
        controller.message = PostGameMessage(
            context: message,
            pathScore: pathScore,
            maxPathScore: maxPathScore,
            instrScore: instrScore,
            maxInstrScore: maxInstrScore,
            nextLevelAction: {
                controller.dismissViewControllerAnimated(true, completion: nil)
                controller.gotoNextLevelAndDismiss()
            },
            playAgainAction: {
                controller.dismissViewControllerAnimated(true, completion: nil)
                controller.playAgainAndDismiss()
        })
        if let view = controller.view as? PostGameMessageView {
            view.nextLevelButton.hidden = gameViewController?.level?.nextLevelUrl == ""
        }
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        completion?()
    }
    
    func failurePopup(message: String, completion: (() -> Void)?) {
        let controller = MessageViewController(nil, delegate: self)
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        gameViewController?.presentViewController(controller, animated: true, completion: nil)
        controller.message = FailMessage(
            title: "Oh dear!",
            context: message,
            action: {
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        completion?()
    }
    
    func onStopControls(completion: (() -> Void)?) {
        switchControlMode(.onStopControls, completion: completion)
    }
    
    func gotoNextLevelAndDismiss(completion: (() -> Void)?) {
        if let viewController = gameViewController,
                nextLevelUrl = viewController.level?.nextLevelUrl {
            viewController.levelUrl = nextLevelUrl
        }
        completion?()
    }
    
    func playAgainAndDismiss(completion:(() -> Void)?) {
        gameViewController?.blockTableViewController?.clearBlocks()
        gameViewController?.gameMapViewController?.mapScene?.van.reset()
        gameViewController?.gameMapViewController?.mapScene?.resetMap()
        gameViewController?.gameMapViewController?.animationHandler?.resetVariables()
        switchControlMode(.onStopControls, completion: nil)
    }
    
    func submitBlocks(script: String, completion: (() -> Void)?) {
        gameViewController?.runJavaScript(script, callback: completion)
    }
    
    func executeAnimation(animationQueues: [[Animation]], completion: (() -> Void)?) {
        let animationHandler = gameViewController?.gameMapViewController?.animationHandler
        animationHandler?.resetVariables()
        animationHandler?.executeAnimations(animationQueues)
        completion?()
    }
    
    func centerOnNodeDuringAnimation(node: SKNode, completion: (() -> Void)?) {
        if let controlMode = gameMenuViewController?.controlMode
            where controlMode == .onPlayControls {
                gameMapViewController?.mapScene?.centerOnNode(node)
        }
        completion?()
    }
    
    func setBlocklyEditable(editable: Bool, completion: (() -> Void)?) {
        blocklyViewController?.editable = editable
        completion?()
    }
    
    func stop(completion: (() -> Void)?) {
        blocklyViewController?.resetHighlightCellVariables()
        gameMapViewController?.mapScene?.van.reset()
        gameMapViewController?.mapScene?.resetMap()
        gameMapViewController?.animationHandler?.resetVariables()
        switchControlMode(.onStopControls, completion: completion)
    }
    
    func terminateAnimation(completion: (() -> Void)?) {
        gameMapViewController?.mapScene?.removeAllActions()
        gameMapViewController?.mapScene?.van.removeAllActions()
        completion?()
    }
    
    func resetVan(completion: (() -> Void)?) {
        gameMapViewController?.mapScene?.van.reset()
        completion?()
    }
    
    func runAnimation(runAnimation: Bool, completion: (() -> Void)?) {
        gameMapViewController?.animationHandler?.runAnimation = runAnimation
        completion?()
    }
    
    func stepAnimation(step: Bool, completion: (() -> Void)?) {
        gameMapViewController?.animationHandler?.step = step
        completion?()
    }
    
}
