//
//  Helpers.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/15/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import UIKit

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}

/// UIButtion extension that adds support for automatically
/// adding scaling animations on the button press and the 
/// button release events.
extension UIButton {

    /// Adds the animation events for this button.
    func addTouchEvents() {
        self.addTarget(self, action: #selector(UIButton.animatePressed(_:)),
                         forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(UIButton.animateReset(_:)),
                         forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(UIButton.animateReset(_:)),
                         forControlEvents: .TouchUpOutside)
    }

    /// Animates the input buttown with a shrinking animation.
    func animateReset(sender: UIButton) {
        UIView.animateWithDuration(0.09, animations: {
            sender.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

    /// Animates the input button to the identity transformation.
    func animatePressed(sender: UIButton) {
        UIView.animateWithDuration(0.09, animations: {
            sender.transform = CGAffineTransformMakeScale(0.95, 0.95)
            }, completion: nil)
    }

}