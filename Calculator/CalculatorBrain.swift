//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Rutvij Dhotey on 9/4/16.
//  Copyright © 2016 Rutvij Dhotey. All rights reserved.
//

import Foundation
//never include UIKIT here

class CalculatorBrain {
    private var accumulator = 0.0
    
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operation: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "✕": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    
    }
    
    func performOperation(symbol: String){
        if let operation = operation[symbol] {
            switch operation{
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand ,accumulator)
                    pending = nil;
                }
            }
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction : (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
