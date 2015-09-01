//
//  Config.swift
//  Blockly
//
//  Created by Joey Chan on 06/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

/**
    Position offset of Previous Connection from the top left of the blockly
 */
let PreviousConnectionOffset = CGPointMake(60, BlankSize.height)

/**
    Position offset of Next Connection from the bottom left of the blockly
 */
let NextConnectionOffset = CGPointMake(60, TabSize.height)

/**
    Animation Duration for the blockly to snap to another blockly
 */
let ConnectionSnapDuration: NSTimeInterval = 0.2

/**
    Default size of a blockly
 */
let DefaultBlocklySize = CGSizeMake(150, 30)

/**
    Default initial center position of the blockly when it first appears on the workspace
 */
let DefaultBlocklyCenter = CGPointMake(400, 400)

/**
    Default color of the Blockly background
 */
let DefaultBlocklyBackgroundColor = UIColor(red: 64/255, green: 208/255, blue: 192/255, alpha: 1) //#40D0C0

/**
    Size of a blank(aka female connection, hole, etc)
 */
let BlankSize = CGSizeMake(20, 5)

/**
    Size of a tab(aka male connection, key, etc)
 */
let TabSize = CGSizeMake(20, 5)

/**
    Radius of the range which a connection should search withing to locate another valid connection
 */
let SearchRadius: CGFloat = 20

/**
    Position offset of a input from the left of the blockly
 */
let InputOffset: CGFloat = 10

/**
    Height of the empty area below a StatementInput
 */
let ShelfHeight: CGFloat = 10

/**
    Ratio of height and width a blockly should be bumped away from its original position
 */
let BumpOffsetRatio: CGFloat = 1.2

/**
    Animation duration of a blockly to be bumped away
 */
let BumpDuration = NSTimeInterval(0.2)

/**
    Default background color of an input
 */
let DefaultInputBackgroundColor = UIColor.clearColor()

/**
    Default size for an input
 */
let DefaultInputFrame = CGRect(origin: CGPointZero, size: DefaultBlocklySize)

/**
    Default width for the blockly generator area
 */
let BlocklyGeneratorWidth: CGFloat = 200

/**
    Default size of a blockly menu button
 */
let BlocklyGeneratorButtonSize: CGSize = CGSizeMake(50, 50)

