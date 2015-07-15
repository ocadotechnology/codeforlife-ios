//
//  AnimationHandler.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class AnimationHandler {
    
    weak var map: Map? {
        return SharedContext.MainGameViewController?.gameMapViewController?.map
    }
    
    lazy var animationQueue: [Animation] = []
    var currentIndex = 0
    var runAnimation = false {
        didSet {
            if runAnimation {
                
                // reset animations if all animations are run
                if isAnimationCycleFinished {
                    resetAnimation()
                }
                runAnimations()
            }
        }
    }
    
    var isAnimationCycleFinished: Bool {
        return currentIndex >= animationQueue.count
    }
    
    
    var isAnimationRunning = false {
        didSet {
            if !isAnimationRunning {
                runAnimation = runAnimation.boolValue
            }
        }
    }
    
    func addAnimation(animation: Animation) {
        animationQueue.last?.nextAnimation = animation
        animationQueue.append(animation)
    }
    
    func removeAllAnimations() {
        animationQueue.removeAll(keepCapacity: false)
    }
    
    private func resetAnimation() {
        self.currentIndex = 0
        self.map?.player.resetPosition()
        
    }
    
    private func runAnimations() {
        isAnimationRunning = true
        animationQueue[currentIndex++].executeAnimation {
            [unowned self] in
            
            if self.isAnimationCycleFinished {
                self.runAnimation = false
            }
            
            // Notify to run next Animation if exists one
            self.isAnimationRunning = false
        }
    }
    
    
    
}
