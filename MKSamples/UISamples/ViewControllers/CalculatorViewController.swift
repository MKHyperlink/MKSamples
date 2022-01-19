//
//  CalculatorViewController.swift
//  MKSamples
//
//  Created by mike_chen on 2022/1/14.
//  Copyright © 2022 Mike. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_calculator" }
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnPercentage: UIButton!
    @IBOutlet weak var btnDot: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnEquality: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnEight: UIButton!
    @IBOutlet weak var btnNine: UIButton!
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnDoubleZero: UIButton!
    @IBOutlet weak var ttfdInput: UITextField!
    
    private var viewModel: Calculator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataInit()
    }
    
    private func dataInit() {
        self.viewModel = CalculatorViewModel()
        self.viewModel?.uiBehavior = self
    }
    
    @IBAction func pressClear(_ sender: Any) {
        self.viewModel?.clear()
    }
    
    @IBAction func pressBack(_ sender: Any) {
        self.viewModel?.backSpace()
    }
    
    @IBAction func pressPercentage(_ sender: Any) {
        self.viewModel?.percentage()
    }
    
    @IBAction func pressDivide(_ sender: Any) {
        self.viewModel?.set(mode: .divide)
    }
    
    @IBAction func pressMultiply(_ sender: Any) {
        self.viewModel?.set(mode: .multiply)
    }
    
    @IBAction func pressSubtract(_ sender: Any) {
        self.viewModel?.set(mode: .subtract)
    }
    
    @IBAction func pressAdd(_ sender: Any) {
        self.viewModel?.set(mode: .add)
    }
    
    @IBAction func pressEquality(_ sender: Any) {
        self.viewModel?.equal()
    }
    
    @IBAction func pressDot(_ sender: Any) {
        self.viewModel?.dot()
    }
    
    @IBAction func pressDoubleZero(_ sender: Any) {
        self.viewModel?.doubleZero()
    }
    
    @IBAction func pressNumber(_ sender: UIButton) {
        self.viewModel?.pressNumber(number: sender.tag)
    }
}



extension CalculatorViewController: CalculatorUIBehavior {
    func update(value: String) {
        self.ttfdInput.text = value
    }
}
