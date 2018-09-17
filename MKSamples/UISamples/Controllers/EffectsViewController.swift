//
//  EffectsViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/9/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class EffectsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_01" }
    
    var viewModel: EffectsViewModel?
    var keyboardShift: KeyboardShiftDelegate!
    
    @IBOutlet weak var vwBlock: UIView!
    @IBOutlet weak var ttfdInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = EffectsViewModel()
        
        keyboardShift = KeyboardShift()
        keyboardShift.viewDelegate = self.view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardShift.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardShift.unregisterFromKeyboardNotifications()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardShift.calculatePositionY(textField)
    }
    
    //MARK: - button actions
    @IBAction func btnStartAct() {
        viewModel?.shake(view: self.vwBlock)
    }

}
