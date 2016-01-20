//
//  BlocklyConfiguration.swift
//  Blockly
//
//  Created by Joey Chan on 06/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

// Not is use yet.
protocol BlocklyConfiguration: class {
    // Position offset of Previous Connection from the top left of the blockly
    var PreviousConnectionOffset : CGPoint {get}
    
    // Position offset of Next Connection from the bottom left of the blockly
    var NextConnectionOffset : CGPoint {get}
    
    // Animation Duration for the blockly to snap to another blockly
    var ConnectionSnapDuration : NSTimeInterval {get}
    
    // Default size of a blockly
    var DefaultBlocklySize : CGSize {get}
    
    // Default initial center position of the blockly when it first appears on the workspace
    var DefaultBlocklyCenter : CGPoint {get}
    
    // Default color of the Blockly background
    var DefaultBlocklyBackgroundColor : UIColor {get}
    
    // Size of a blank(aka female connection, hole, etc)
    var BlankSize : CGSize {get}
    
    // Size of a tab(aka male connection, key, etc)
    var TabSize : CGSize {get}
    
    // Radius of the range which a connection should search withing to locate another valid connection
    var SearchRadius : CGFloat {get}
    
    // Position offset of a input from the left of the blockly
    var InputOffset: CGFloat {get}
    
    // Height of the empty area below a StatementInput
    var ShelfHeight: CGFloat {get}
    
    // Ratio of height and width a blockly should be bumped away from its original position
    var BumpOffsetRatio: CGFloat {get}
    
    // Animation duration of a blockly to be bumped away
    var BumpDuration : NSTimeInterval {get}
    
    // Default background color of an input
    var DefaultInputBackgroundColor: UIColor {get}
    
    // Default size for an input
    var DefaultInputFrame : CGRect {get}
    
    // Default width for the blockly generator area
    var BlocklyGeneratorWidth: CGFloat {get}
    
    // Default size of a blockly menu button
    var BlocklyGeneratorButtonSize: CGSize {get}
    
}

let PreviousConnectionOffset = CGPointMake(40, BlankSize.height)
let NextConnectionOffset = CGPointMake(40, TabSize.height)
let ConnectionSnapDuration: NSTimeInterval = 0.2
let DefaultBlocklySize = CGSizeMake(125, 30)
let DefaultBlocklyCenter = CGPointMake(400, 400)
let DefaultBlocklyBackgroundColor = UIColor(red: 64/255, green: 208/255, blue: 192/255, alpha: 1) //#40D0C0
let BlankSize = CGSizeMake(20, 5)
let TabSize = CGSizeMake(20, 5)
let SearchRadius: CGFloat = 20
let InputOffset: CGFloat = 10
let ShelfHeight: CGFloat = 10
let BumpOffsetRatio: CGFloat = 1.2
let BumpDuration = NSTimeInterval(0.2)
let DefaultInputBackgroundColor = UIColor.clearColor()
let DefaultInputFrame = CGRect(origin: CGPointZero, size: CGSizeMake(125, 30))
let BlocklyGeneratorWidth: CGFloat = 160
let BlocklyGeneratorButtonSize: CGSize = CGSizeMake(50, 50)