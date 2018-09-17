
//
//  EffectsViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/9/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation
import UIKit

class EffectsViewModel {
    
    func shake(view: UIView) {
        view.transform = CGAffineTransform(translationX: 10, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            view.transform = .identity
        }, completion: nil)
    }

}
