//
//  BlocklyFactory.swift
//  Blockly
//
//  Created by Joey Chan on 31/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class BlocklyFactory {

    private static func createTemplateBlock() -> UIBlocklyView {
        return UIBlocklyView(buildClosure: {
            (blockly) in
            blockly.setTypeId(BlocklyType.Default)
        })
    }


}