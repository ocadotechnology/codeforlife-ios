//
//  PostGameMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class PostGameMessageView: MessageView {

    let containerViewCornerRadius: CGFloat = 50
    let containerViewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25
    
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextView: UITextView!
    @IBOutlet weak var playAgainButton: UIButton!
    
    class func instsanceFromXib(message: Message) -> PostGameMessageView {
        var view = UINib(nibName: "PostGameMessageView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PostGameMessageView
        view.message = message
        return view
    }
    
    @IBAction func executeNextLevelAction() {
        executeButtonAction()
    }
    
    @IBAction func executePlayAgainAction() {
        if let message = self.message as? PostGameMessage {
            message.playAgainAction?()
        }
    }
    
    
    override func reloadContent() {
        titleLabel.text = message!.title
        contextView.text = message!.context
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = containerViewCornerRadius
        layer.masksToBounds = true
        layer.borderColor = kC4LMessageBorderColour.CGColor
        layer.borderWidth = containerViewBorderWidth
        nextLevelButton.layer.cornerRadius = messageButtonCornerRadius
        nextLevelButton.layer.masksToBounds = true
        nextLevelButton.layer.borderWidth = messageButtonBorderWidth
        nextLevelButton.layer.borderColor = kC4lMessageButtonBorderColour.CGColor
        nextLevelButton.backgroundColor = kC4lMessageButtonBackgroundColour
        playAgainButton.layer.cornerRadius = messageButtonCornerRadius
        playAgainButton.layer.masksToBounds = true
        playAgainButton.layer.borderWidth = messageButtonBorderWidth
        playAgainButton.layer.borderColor = kC4lMessageButtonBorderColour.CGColor
        playAgainButton.backgroundColor = kC4lMessageButtonBackgroundColour
    }

}
