//
//  BlocklyInterpreter.swift
//  Pods
//
//  Created by Joey Chan on 26/08/2015.
//
//

import Foundation

public typealias Closure = (BlocklyInterpreter, Blockly) -> Int
public class BlocklyInterpreter {
    
    public var vars = [String: String]()
    private var regs: [Int] = [0]
    public var lastReg: Int {
        get { return regs[regs.count-1] }
        set { regs[regs.count-1] = newValue }
    }
    
    public func pushReg() { regs.append(0) }
    public func popReg() -> Int { return regs.removeLast() }
    
    public static var closureMap = [Int : Closure]()
    
    public func interpret(blocklyCore: Blockly?) {
        if let blocklyCore = blocklyCore,
                closure = BlocklyInterpreter.closureMap[blocklyCore.typeId] {
            closure(self, blocklyCore)
        } else {
            proceedToNextBlockly(blocklyCore)
        }
    }
    
    public func proceedToNextBlockly(blocklyCore: Blockly?) -> Int {
        if let nextBlocklyCore = blocklyCore?.nextBlockly {
            interpret(nextBlocklyCore)
        } else if let parentBlocklyCore = blocklyCore?.parentBlockly {
            regs.removeLast()
            regs[regs.count-1]++
            interpret(parentBlocklyCore)
        } else {
            exit(0)
        }
        return -1
    }
    
    public func proceedToSpecificBlockly(blocklyCore: Blockly?) -> Int {
        if let blocklyCore = blocklyCore {
            interpret(blocklyCore)
        } else {
            exit(0)
        }
        return -1
    }
    
    func exit(exitCode: Int) -> Int {
        switch exitCode {
        case 0 : println(" -- Interpretation has finished successfully -- ")
        case 1 : println(" -- Cannot find if condition -- ")
        default: println(" -- Unknown Error --")
        }
        println(" -- Interpretation Ended -- ")
        return -1
    }
    
    func getIfClosure(blockly: Blockly) -> Closure? {
        var closure: Closure?
        if let index = blockly.inputConnections[0].targetConnection?.sourceBlockly.typeId {
            closure = BlocklyInterpreter.closureMap[index]
        }
        return closure
    }
    
    
}