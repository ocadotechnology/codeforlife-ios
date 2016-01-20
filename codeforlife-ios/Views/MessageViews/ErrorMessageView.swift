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
    let messageButtonBorderWidth: CGFloat = 3
    let messageButtonCornerRadius: CGFloat = 20

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    class func instsanceFromXib(message: Message) -> ErrorMessageView {
        let view = UINib(nibName: "ErrorMessageView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ErrorMessageView
        view.message = message
        return view
    }
    
    @IBAction func executeAction() {
        executeButtonAction()
    }
    
    override func reloadContent() {
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
