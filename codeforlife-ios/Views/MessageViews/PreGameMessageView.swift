//
//  PreGameMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class PreGameMessageView: MessageView {
    
    let messageButtonBorderWidth: CGFloat = 3
    let messageButtonCornerRadius: CGFloat = 20

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    class func instsanceFromXib(message: Message) -> PreGameMessageView {
        var view = UINib(nibName: "PreGameMessageView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PreGameMessageView
        view.message = message
        return view
    }

    @IBAction func executeAction() {
        executeButtonAction()
    }
    
    override func reloadContent() {
        containerView.center = self.center
        titleLabel.text = message!.title
        contextLabel.text = message!.context
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        messageButton.layer.cornerRadius = messageButtonCornerRadius
        messageButton.layer.masksToBounds = true
        messageButton.layer.borderWidth = messageButtonBorderWidth
        messageButton.layer.borderColor = kC4lMessageButtonBorderColour.CGColor
        messageButton.backgroundColor = kC4lMessageButtonBackgroundColour
    }
    
}
