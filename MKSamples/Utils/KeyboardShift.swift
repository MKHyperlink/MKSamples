//
//  KeyboardShift.swift
//  portal_network_iOS
//
//  Created by Mike on 04/01/2018.
//  Copyright © 2018 Orange. All rights reserved.
//

import Foundation
import UIKit


protocol KeyboardShiftable {
    var viewDelegate: UIView! { get set }
    
    func registerForKeyboardNotifications()
    func unregisterFromKeyboardNotifications()
    func calculatePositionY(_ textField: UITextField)
}

public class KeyboardShift: NSObject, KeyboardShiftable {

    // View delegate
    weak var viewDelegate: UIView! {
        didSet {
            self.setTapRecognizer()
        }
    }

    // Keyboard
    private var keyboardSize: CGFloat = 0
    private var keyboardAlreadyShow: Bool = false
    private var currentResponderPositionY: CGFloat = 0
    private var originalY: CGFloat = 0
    
    private func reset() {
        self.keyboardSize = 0
        self.keyboardAlreadyShow = false
        self.currentResponderPositionY = 0
        self.originalY = 0
    }
    
    private func setTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(KeyboardShift.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        self.viewDelegate.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShown(notification: NSNotification) {
        if let info = notification.userInfo,
           let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardSize = frame.cgRectValue.height
            updateScreen()
        }
        keyboardAlreadyShow = true
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        keyboardAlreadyShow = false
        var newFrame = self.viewDelegate.frame
        newFrame.origin.y = self.originalY
        self.viewDelegate.frame = newFrame
        
        self.reset()
    }
    
    @objc func dismissKeyboard() {
        self.viewDelegate.endEditing(true)
    }
    
    private func updateScreen() {
        if self.originalY == 0 && !self.keyboardAlreadyShow {
            self.originalY = self.viewDelegate.frame.origin.y
        }
        
        let offset = UIScreen.main.bounds.height - currentResponderPositionY - keyboardSize
        let predictiveHeight: CGFloat = 37
        if offset < predictiveHeight {
            var newFrame = self.viewDelegate.frame
            newFrame.origin.y = offset - predictiveHeight
            self.viewDelegate.frame = newFrame
        }
    }
    
    func registerForKeyboardNotifications() {
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(KeyboardShift.keyboardWillShown(notification:)),
                           name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(KeyboardShift.keyboardWillBeHidden(notification:)),
                           name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterFromKeyboardNotifications () {
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func calculatePositionY(_ textField: UITextField) {
        self.currentResponderPositionY = textField.convert(textField.bounds.origin, to: self.viewDelegate).y + textField.bounds.height
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
