//
//  PostGameMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class PostGameMessageView: MessageView {

    let messageButtonBorderWidth: CGFloat = 3
    let messageButtonCornerRadius: CGFloat = 20
    
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var instrScoreLabel: UILabel!
    @IBOutlet weak var pathScoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var pathScoreImages: UIView!
    @IBOutlet weak var instrScoreImages: UIView!
    
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
        if let message = self.message as? PostGameMessage {
            pathScoreLabel.text = "Route score: \(message.pathScore)/\(message.maxPathScore)"
            instrScoreLabel.text = "Algorithm score: \(message.instrScore)/\(message.maxInstrScore)"
            totalScoreLabel.text = "Your total score: \(message.pathScore + message.instrScore)/\(message.maxInstrScore + message.maxPathScore)"
            titleLabel.text = message.title
            messageLabel.text = message.context
            
            for index in 0 ..< 10 {
                let imageView = UIImageView(image: UIImage(named: Float(index+1) <= message.pathScore ? "coin_gold" : "coin_empty_transparent"))
                imageView.frame = CGRect(origin: CGPointMake(frame.origin.x+CGFloat(index)*45, frame.origin.y), size: CGSize(width: 45, height: 45))
                pathScoreImages.addSubview(imageView)
            }
            
            for index in 0 ..< 10 {
                let imageView = UIImageView(image: UIImage(named: Float(index) <= message.pathScore ? "coin_gold" : "coin_empty_transparent"))
                imageView.frame = CGRect(origin: CGPointMake(frame.origin.x+CGFloat(index)*45, frame.origin.y), size: CGSize(width: 45, height: 45))
                instrScoreImages.addSubview(imageView)
            }
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
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
