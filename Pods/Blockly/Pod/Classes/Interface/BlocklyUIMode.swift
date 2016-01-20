//
//  BlocklyUIMode.swift
//  Pods
//
//  Created by Joey Chan on 24/09/2015.
//
//

import Foundation

public class BlocklyUIMode {
    public static let None      = 0b00000000
    public static let Deletable = 0b00000010
    public static let Editable  = 0b00000100
    public static let Movable   = 0b00001000
    public static let All       = 0b11111111
}
