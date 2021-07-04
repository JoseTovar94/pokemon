//
//  CircularView.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

@IBDesignable
class CircularView: UIView {
    private let kRotationAnimationKey = "rotationanimationkey"
    
    @IBInspectable var progressColor: UIColor = .pokemonPrimary {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    @IBInspectable var trackColor: UIColor = .white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 3.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var progress: CGFloat = 0.0
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    
    fileprivate func updateView() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0.0
//        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
    }
    
    func setProgress(value: CGFloat, withDuration duration: TimeInterval? = nil) {
        progress = value
        if let duration = duration {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = 0
            animation.toValue = progress
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            progressLayer.strokeEnd = CGFloat(value)
            progressLayer.add(animation, forKey: "animateprogress")
        } else {
            progressLayer.strokeEnd = CGFloat(progress)
        }
    }
    
    func startIndeterminate() {
        setProgress(value: 0.8)
        
        if layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = 1.0
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    func stop() {
        if layer.animation(forKey: kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
}
