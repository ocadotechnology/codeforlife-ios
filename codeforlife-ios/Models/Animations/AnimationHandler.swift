//
//  AnimationHandler.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public class AnimationHandler {
    
    weak var afDelegate: GameViewControllerDelegate?
    
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
                    afDelegate?.switchControlMode(.onPauseControls, completion: nil)
                }
            }
        }
    }
    
    public init(delegate: GameViewControllerDelegate?) {
        self.afDelegate = delegate
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
    }
    
    private func resetAnimation() {
        self.currentIndex = 0
        self.afDelegate?.resetVan(nil)
    }
    
    private func runAnimations() {
        println("===== \(currentIndex+1)/\(animationQueues.count) ======")
        println("Number of Animations to run = \(animationQueues[currentIndex].count)")
        runningAnimationsRemained = animationQueues[currentIndex].count
        for animation in animationQueues[currentIndex++] {
            animation.execute {
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
