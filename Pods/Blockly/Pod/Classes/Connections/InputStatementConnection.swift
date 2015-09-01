//
//  InputStatementConnection.swift
//  Blockly
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class InputStatementConnection: InputConnection {
    
    init(_ sourceBlock: BlocklyCore) {
        super.init(sourceBlock, InputType.Statement)
    }
    
}