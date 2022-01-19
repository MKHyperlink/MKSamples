//
//  CalculatorViewModel.swift
//  MKSamples
//
//  Created by mike_chen on 2022/1/17.
//  Copyright © 2022 Mike. All rights reserved.
//

import Foundation

protocol CalculatorUIBehavior: AnyObject {
    func update(value: String)
}

protocol Calculator {
    var uiBehavior: CalculatorUIBehavior? { get set }
    func clear()
    func backSpace()
    func pressNumber(number: Int)
    func dot()
    func doubleZero()
    
    func set(mode: CalculateMode)
    func percentage()
    func equal()
}


enum CalculateMode {
    case add
    case subtract
    case divide
    case multiply
    case none
    
    func calculate(source: [Double]) -> Double? {
        guard source.count > 0 else { return nil }
        
        var res = source[0]
        switch self {
        case .add:
            res = source.reduce(0, +)
        case .subtract:
            res = source[1...].reduce(source[0], -)
        case .divide:
            res = source[1...].reduce(source[0], /)
        case .multiply:
            res = source.reduce(1, *)
        case .none:
            break
        }
        
        return res
    }
}


class CalculatorViewModel {
    weak var uiBehavior: CalculatorUIBehavior?

    private enum State {
        case waitingInput, none
    }
    
    private let defaultValue = "0"
    private let dotSign: String = "."
    private lazy var value: String = defaultValue {
        didSet {
            self.uiBehavior?.update(value: value)
        }
    }
    private var currenMode: CalculateMode = .none {
        willSet {
            if newValue != currenMode {
                self.equal()
            }
        }
        didSet {
            if currenMode == oldValue, currenMode != .none {
                self.equal()
            }
            self.state = .waitingInput
        }
    }
    
    private var calQueue = [Double]()
    private var state: State = .none
}


extension CalculatorViewModel: Calculator {
    private func checkValue() -> Bool {
        guard !self.value.isEmpty else { return false }
        
        var isValid = false
        let ary = self.value.components(separatedBy: self.dotSign)
        if ary.count >= 2 {
            isValid = true
        } else if let iVal = Int(self.value), iVal > 0 {
            isValid = true
        }
     
        return isValid
    }
    
    func clear() {
        self.currenMode = .none
        self.value = self.defaultValue
        self.calQueue.removeAll()
        self.state = .none
    }
    
    func backSpace() {
        guard self.checkValue(), self.value.count > 1 else {
            self.clear()
            return
        }
        let eIdx = self.value.index(before: self.value.endIndex)
        self.value = String(self.value[..<eIdx])
    }
    
    func pressNumber(number: Int) {
        if self.state == .waitingInput {
            self.value = defaultValue
            self.state = .none
        }
        
        if self.value.count == 1, self.value == self.defaultValue {
            self.value = String(number)
        } else {
            self.value += String(number)
        }
    }
    
    func dot() {
        guard !self.value.contains(self.dotSign) else { return }
        self.value += self.dotSign
    }
    
    func doubleZero() {
        guard self.checkValue() else { return }
        self.value += "00"
    }
    
    private func updateValue(res: Double?) {
        guard let res = res else { return }
        
        self.value = String(res)
        self.calQueue[0] = res
        
        // 只保留最後一次計算結果
        if self.calQueue.count > 1 {
            self.calQueue.removeLast()
        }
    }
    
    func set(mode: CalculateMode) {
        self.currenMode = mode
    }
    
    func percentage() {
        guard let val = Double(self.value) else { return }
        self.value = String(val / 100)
    }
    
    func equal() {
        guard let val = Double(self.value) else { return }
        self.calQueue.append(val)
        // 無先乘除後加減
        let res = self.currenMode.calculate(source: self.calQueue)
        self.updateValue(res: res)
    }
}
