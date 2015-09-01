//
//  BlocklyVCExtensionGestureRecognizer.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

extension BlocklyViewController {
    
    func setupGestureRecognizer() {
        recognizer = BlocklyPanGestureRecognizer(self)
        view.addGestureRecognizer(recognizer!)
    }
    
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        recognizer?.handlePanGesture(sender)
    }
}