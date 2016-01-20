//
//  InputConnection.swift
//  Blockly
//
//  Created by Joey Chan on 04/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

public class InputConnection: Connection {

    public override func connect(otherConnection: Connection?) {}
    public override func matchSearchCondition(otherConnection: Connection) -> Bool {
        if otherConnection is InputConnection {
            return false
        }
        return otherConnection.matchSearchCondition(self)
    }

}