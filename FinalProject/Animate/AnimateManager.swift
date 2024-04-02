//
//  AnimateManager.swift
//  FinalProject
//
//  Created by apple on 02.04.2024.
//

import UIKit
import AudioToolbox

final class AnimateManager {
    
    private init() {}
    
    static func getShakingAnimates(shakesView: UIView) -> CABasicAnimation {
        AudioServicesPlaySystemSound(SystemSoundID(1053))
        let animate = CABasicAnimation(keyPath: "position")
        animate.duration = 0.07
        animate.repeatCount = 4
        animate.autoreverses = true
        
        let fromPoint = CGPoint(x: shakesView.center.x - 5, y: shakesView.center.y)
        let toPoint = CGPoint(x: shakesView.center.x + 5, y: shakesView.center.y)
        
        animate.fromValue = fromPoint
        animate.toValue = toPoint
        
        shakesView.layer.add(animate, forKey: "position")
        return animate
    }
}
