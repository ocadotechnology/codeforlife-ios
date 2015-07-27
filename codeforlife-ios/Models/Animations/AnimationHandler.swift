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
    
    lazy var animationQueues: [[Animation]] = [[]]
    
    var currentIndex = 0
    
    var step = false
    
    var runAnimation = false {
        didSet {
            if runAnimation && runningAnimationsRemained == 0 {
                // reset animations if all animations are run
                if isAnimationCycleFinished {
                    resetAnimation()
                }
                runAnimations()
            }
        }
    }
    
    var isAnimationCycleFinished: Bool {
        return currentIndex >= animationQueues.count && runningAnimationsRemained == 1
    }
    
    var runningAnimationsRemained = 0 {
        didSet {
            if runningAnimationsRemained == 0 {
                runAnimation = step ? false : runAnimation.boolValue
                if step {
                    step = false
                    SharedContext.MainGameViewController?.gameMenuViewController?.controlMode = GameMenuViewController.ControlMode.onPauseControls
                }
            }
        }
    }
    
    func executeAnimations(animationQueues: [[Animation]]) {
        self.animationQueues = animationQueues
        currentIndex = 0
        runAnimation = true
    }
    
    func removeAllAnimations() {
        animationQueues.removeAll(keepCapacity: false)
    }
    
    func resetVariables() {
        currentIndex = 0
        runAnimation = false
        runningAnimationsRemained = 0
    }
    
    private func resetAnimation() {
        self.currentIndex = 0
        self.map?.van.reset()
    }
    
    private func runAnimations() {
        println("===== \(currentIndex+1)/\(animationQueues.count) ======")
        runningAnimationsRemained = animationQueues[currentIndex].count
        for animation in animationQueues[currentIndex++] {
            animation.executeAnimation {
                [unowned self] in
                if self.isAnimationCycleFinished {
                    self.runAnimation = false
                }
                // Notify to run next Animation if all concurrent animations finish
                self.runningAnimationsRemained--
            }
        }
    }
}
