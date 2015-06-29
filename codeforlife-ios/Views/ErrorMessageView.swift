//
//  ErrorMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class ErrorMessageView: MessageView {
    
    let viewCornerRadius: CGFloat = 50
    let viewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextView: UITextView!
    @IBOutlet weak var messageButton: UIButton!
    
    class func instsanceFromXib() -> ErrorMessageView {
        return UINib(nibName: "ErrorMessageView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ErrorMessageView
    }
    
    @IBAction func executeAction() {
        executeButtonAction()
    }
    
    override func reloadContent() {
        titleLabel.text = message!.title
        contextView.text = message!.context
        messageButton.titleLabel!.text = message!.buttonText
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = viewCornerRadius
        layer.masksToBounds = true
        layer.borderColor = kC4LMessageBorderColour.CGColor
        layer.borderWidth = viewBorderWidth
        messageButton.layer.cornerRadius = messageButtonCornerRadius
        messageButton.layer.masksToBounds = true
        messageButton.layer.borderWidth = messageButtonBorderWidth
        messageButton.layer.borderColor = kC4lMessageButtonBorderColour.CGColor
        messageButton.backgroundColor = kC4lMessageButtonBackgroundColour
    }


}
