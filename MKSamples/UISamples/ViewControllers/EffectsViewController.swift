//
//  EffectsViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/9/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class EffectsViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_effects" }
    
    var keyboardShift: KeyboardShiftable?
    
    @IBOutlet weak var vwBlock: UIView!
    @IBOutlet weak var ttfdInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardShift = KeyboardShift()
        keyboardShift?.viewDelegate = self.view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardShift?.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardShift?.unregisterFromKeyboardNotifications()
    }
    
    //MARK: - button actions
    @IBAction func btnStartAct() {
        self.vwBlock.shake()
    }
}

extension EffectsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardShift?.calculatePositionY(textField)
    }
    
}
