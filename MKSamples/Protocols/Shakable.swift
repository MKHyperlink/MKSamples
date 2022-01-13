//
//  Shakable.swift
//  MKSamples
//
//  Created by mike_chen on 2022/1/12.
//  Copyright © 2022 Mike. All rights reserved.
//

import Foundation
import UIKit

protocol Shakable {}

extension Shakable where Self: UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 10, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 50,
                       options: [.curveEaseOut,
                                 .beginFromCurrentState,
                                 .allowUserInteraction],
                       animations: {
            self.transform = .identity
        },
                       completion: nil)
    }
}

extension UIView: Shakable {}
