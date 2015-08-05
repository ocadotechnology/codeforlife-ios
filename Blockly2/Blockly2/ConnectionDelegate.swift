//
//  ConnectionDelegate.swift
//  Blockly2
//
//  Created by Joey Chan on 05/08/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol ConnectionDelegate {
    func connect(otherConnection: Connection?)
    func updateSourceBlockCenter()
    func matchSearchCondition(otherConnection: Connection) -> Bool
}
