//
//  BlocklyInterpreter.swift
//  Pods
//
//  Created by Joey Chan on 26/08/2015.
//
//

import Foundation

public typealias Closure = (BlocklyInterpreter, BlocklyCore, Int) -> Int
public class BlocklyInterpreter {
    
    public static var closureMap = [Int : Closure]()
    
    public func interpret(blocklyCore: BlocklyCore?, _ i: Int) {
        if let blocklyCore = blocklyCore,
                closure = BlocklyInterpreter.closureMap[blocklyCore.typeId] {
            if i == 0 {
                proceedToNextBlock(blocklyCore, 1)
            } else {
                closure(self, blocklyCore, i)
            }
        } else {
            proceedToNextBlock(blocklyCore, i)
        }
    }
    
    public func proceedToNextBlock(blocklyCore: BlocklyCore?, _ i: Int) {
        if let nextBlocklyCore = blocklyCore?.nextBlocklyCore {
            interpret(nextBlocklyCore, i)
        } else if let parentBlocklyCore = blocklyCore?.parentBlocklyCore {
            interpret(parentBlocklyCore, i-1)
        } else {
            exit(0)
        }
    }
    
    public func proceedToSpecificBlock(blocklyCore: BlocklyCore?, _ i: Int) {
        if let blocklyCore = blocklyCore {
            interpret(blocklyCore, i)
        } else {
            exit(0)
        }
    }
    
    func exit(exitCode: Int) {
        switch exitCode {
        case 0 : println(" -- Interpretation has finished successfully -- ")
        case 1 : println(" -- Cannot find if condition -- ")
        default: println(" -- Unknown Error --")
        }
        println(" -- Interpretation Ended -- ")
    }
    
    
}