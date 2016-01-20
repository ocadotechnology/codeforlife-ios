//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class MessageViewController: UIViewController {
    
    weak var gvcDelegate: GameViewControllerDelegate?
    
    weak var message: Message? {
        didSet {
            self.view = message?.view
        }
    }
    
    func executeButtonAction() {
        message?.action?()
    }
    
    func gotoNextLevelAndDismiss() {
        gvcDelegate?.gotoNextLevelAndDismiss(nil)
    }
    
    func playAgainAndDismiss() {
        gvcDelegate?.playAgainAndDismiss(nil)
    }
    
    init(_ coder: NSCoder? = nil, delegate: GameViewControllerDelegate?) {
        self.gvcDelegate = delegate
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required convenience public init(coder: NSCoder) {
        self.init(coder, delegate: nil)
    }

}
