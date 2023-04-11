//
//  OrganicView.swift
//  OrganicDemo
//
//  Created by Alberto Lourenço on 5/5/20.
//  Copyright © 2020 Alberto Lourenco. All rights reserved.
//

import AppKit

struct MorphConfig {
    
    var frame: CGRect = .zero
    var duration: CFTimeInterval = 3
    var rotationDuration: CFTimeInterval = 3
    var rotationEnabled: Bool = true
    
    var shapeStart: CAShapeLayer!
    var shapeEnd: CAShapeLayer!
    
    var colorsStart: Array<CGColor> = []
    var colorsEnd: Array<CGColor> = []
    
    var backgroundColor: NSColor = .clear
    
    init(frame: CGRect = .zero,
         duration: CFTimeInterval = 3,
         rotationEnabled: Bool,
         rotationDuration: CFTimeInterval = 3,
         shapeStart: CAShapeLayer,
         shapeEnd: CAShapeLayer,
         colorsStart: Array<CGColor>,
         colorsEnd: Array<CGColor>,
         backgroundColor: NSColor) {
        
        self.frame = frame
        self.duration = duration
        self.rotationEnabled = rotationEnabled
        self.rotationDuration = rotationDuration
        self.shapeStart = shapeStart
        self.shapeEnd = shapeEnd
        self.colorsStart = colorsStart
        self.colorsEnd = colorsEnd
        self.backgroundColor = backgroundColor
    }
    
    init(frame: CGRect = .zero,
         duration: CFTimeInterval = 3,
         rotationEnabled: Bool,
         rotationDuration: CFTimeInterval = 3,
         colorsStart: Array<CGColor>,
         colorsEnd: Array<CGColor>,
         backgroundColor: NSColor) {
        
        self.frame = frame
        self.duration = duration
        self.rotationEnabled = rotationEnabled
        self.rotationDuration = rotationDuration
        
        self.shapeStart = OrganicShape(frame: frame, type: .start)
        self.shapeEnd = OrganicShape(frame: frame, type: .end)
        
        self.colorsStart = colorsStart
        self.colorsEnd = colorsEnd
        self.backgroundColor = backgroundColor
    }
}

class OrganicView: NSView {
    
    private var config: MorphConfig!
    
    init(config: MorphConfig) {
        super.init(frame: config.frame)
        
        self.config = config
        
        self.layer = CALayer()
        self.layer!.addSublayer(self.shapeAnimation())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func shapeAnimation() -> CAGradientLayer {
        
        //  Animations
        
        let animationMorph = CABasicAnimation(keyPath: "path")
        animationMorph.fromValue = config.shapeStart.path
        animationMorph.toValue = config.shapeEnd.path
        animationMorph.duration = config.duration
        animationMorph.autoreverses = true
        animationMorph.repeatCount = Float.infinity
        
        let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
        animationRotation.byValue = NSNumber(value: -Double.pi * 2)
        animationRotation.duration = config.rotationDuration
        animationRotation.repeatCount = Float.infinity
        
        let animationGradient = CABasicAnimation(keyPath: "colors")
        animationGradient.fromValue = config.colorsStart
        animationGradient.toValue = config.colorsEnd
        animationGradient.duration = config.duration
        animationGradient.autoreverses = true
        animationGradient.repeatCount = Float.infinity
        
        //  Layers
        
        let shapeLayer = CAShapeLayer(layer: self.layer!)
        shapeLayer.frame = config.frame
        shapeLayer.path = config.shapeStart.path
        shapeLayer.fillColor = NSColor.yellow.cgColor
        shapeLayer.strokeColor = NSColor.blue.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.add(animationMorph, forKey: "animationPath")
        
        if config.rotationEnabled {
            shapeLayer.add(animationRotation, forKey: "rotation")
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = config.frame
        gradient.colors = config.colorsStart
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.mask = shapeLayer
        gradient.add(animationGradient, forKey: "animationGradient")
        
        return gradient
    }
}

fileprivate class OrganicShape: CAShapeLayer {
    
    enum OrganicShapeType {
        case start
        case end
    }
    
    private var scale: Double = 1.0
    private var shapeType: OrganicShapeType = .start
    
    init(frame: CGRect, type: OrganicShapeType) {
        super.init()
        
        self.frame = frame
        
        shapeType = type
        
        scale = Double(frame.size.width / 300) // shape reference size
        
        self.draw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func draw() {
        
        if shapeType == .start {
            self.path = self.shapeStart()
        }else{
            self.path = self.shapeEnd()
        }
    }
    
    private func shapeStart() -> CGPath {
        
        let path = NSBezierPath()
        path.move(to: CGPoint(x: 37.5 * scale, y: 186 * scale))
        
        path.curve(to: CGPoint(x: 30.3 * scale, y: 139.3 * scale),
                      controlPoint1: CGPoint(x: 25.4 * scale, y: 175.5 * scale),
                      controlPoint2: CGPoint(x: 25.7 * scale, y: 153.7 * scale))
        
        path.curve(to: CGPoint(x: 60.4 * scale, y: 102.6 * scale),
                      controlPoint1: CGPoint(x: 35.1 * scale, y: 124.3 * scale),
                      controlPoint2: CGPoint(x: 43.4 * scale, y: 121.5 * scale))
        
        path.curve(to: CGPoint(x: 103.4 * scale, y: 45 * scale),
                      controlPoint1: CGPoint(x: 91 * scale, y: 68.8 * scale),
                      controlPoint2: CGPoint(x: 83.5 * scale, y: 56.7 * scale))
        
        path.curve(to: CGPoint(x: 173 * scale, y: 43.4 * scale),
                      controlPoint1: CGPoint(x: 125.6 * scale, y: 31.9 * scale),
                      controlPoint2: CGPoint(x: 154.5 * scale, y: 35.5 * scale))
        
        path.curve(to: CGPoint(x: 216.3 * scale, y: 76.6 * scale),
                      controlPoint1: CGPoint(x: 191.1 * scale, y: 51.2 * scale),
                      controlPoint2: CGPoint(x: 188.7 * scale, y: 58.7 * scale))
        
        path.curve(to: CGPoint(x: 263 * scale, y: 104.5 * scale),
                      controlPoint1: CGPoint(x: 245.1 * scale, y: 95.4 * scale),
                      controlPoint2: CGPoint(x: 253.5 * scale, y: 90.9 * scale))
        
        path.curve(to: CGPoint(x: 267.4 * scale, y: 164.7 * scale),
                      controlPoint1: CGPoint(x: 278.6 * scale, y: 126.8 * scale),
                      controlPoint2: CGPoint(x: 269.4 * scale, y: 157.8 * scale))
        
        path.curve(to: CGPoint(x: 248.9 * scale, y: 196.7 * scale),
                      controlPoint1: CGPoint(x: 264.1 * scale, y: 175.9 * scale),
                      controlPoint2: CGPoint(x: 260.3 * scale, y: 188.6 * scale))
        
        path.curve(to: CGPoint(x: 200.3 * scale, y: 207.7 * scale),
                      controlPoint1: CGPoint(x: 232.6 * scale, y: 208.2 * scale),
                      controlPoint2: CGPoint(x: 219.4 * scale, y: 197.4 * scale))
        
        path.curve(to: CGPoint(x: 172.1 * scale, y: 240.9 * scale),
                      controlPoint1: CGPoint(x: 184.1 * scale, y: 216.4 * scale),
                      controlPoint2: CGPoint(x: 187.7 * scale, y: 227.4 * scale))
        
        path.curve(to: CGPoint(x: 92.2 * scale, y: 250.6 * scale),
                      controlPoint1: CGPoint(x: 149.4 * scale, y: 260.6 * scale),
                      controlPoint2: CGPoint(x: 108.3 * scale, y: 266.6 * scale))
        
        path.curve(to: CGPoint(x: 75.6 * scale, y: 195.7 * scale),
                      controlPoint1: CGPoint(x: 77 * scale, y: 235.5 * scale),
                      controlPoint2: CGPoint(x: 92.5 * scale, y: 208.9 * scale))
        
        path.curve(to: CGPoint(x: 37.5 * scale, y: 186 * scale),
                      controlPoint1: CGPoint(x: 63 * scale, y: 186 * scale),
                      controlPoint2: CGPoint(x: 49.7 * scale, y: 196.7 * scale))
        
        path.close()
        
        return path.cgPath
    }
    
    private func shapeEnd() -> CGPath {
        
        let path = NSBezierPath()
        path.move(to: CGPoint(x: 51 * scale, y: 171.3 * scale))
        
        path.curve(to: CGPoint(x: 30.3 * scale, y: 139.3 * scale),
                      controlPoint1: CGPoint(x: 44.9 * scale, y: 153.6 * scale),
                      controlPoint2: CGPoint(x: 35.7 * scale, y: 154.1 * scale))
        
        path.curve(to: CGPoint(x: 51 * scale, y: 72.2 * scale),
                      controlPoint1: CGPoint(x: 22.3 * scale, y: 117.4 * scale),
                      controlPoint2: CGPoint(x: 31 * scale, y: 84.7 * scale))
        
        path.curve(to: CGPoint(x: 118.7 * scale, y: 68.8 * scale),
                      controlPoint1: CGPoint(x: 70.5 * scale, y: 59.9 * scale),
                      controlPoint2: CGPoint(x: 83.8 * scale, y: 77.7 * scale))
        
        path.curve(to: CGPoint(x: 173 * scale, y: 43.4 * scale),
                      controlPoint1: CGPoint(x: 145.2 * scale, y: 62 * scale),
                      controlPoint2: CGPoint(x: 145 * scale, y: 49.9 * scale))
        
        path.curve(to: CGPoint(x: 233.2 * scale, y: 50 * scale),
                      controlPoint1: CGPoint(x: 185 * scale, y: 40.6 * scale),
                      controlPoint2: CGPoint(x: 214.4 * scale, y: 33.8 * scale))
        
        path.curve(to: CGPoint(x: 249.2 * scale, y: 107.7 * scale),
                      controlPoint1: CGPoint(x: 252.2 * scale, y: 66.4 * scale),
                      controlPoint2: CGPoint(x: 249.9 * scale, y: 97.5 * scale))
        
        path.curve(to: CGPoint(x: 239.8 * scale, y: 154.1 * scale),
                      controlPoint1: CGPoint(x: 247.5 * scale, y: 130.5 * scale),
                      controlPoint2: CGPoint(x: 238.9 * scale, y: 133.2 * scale))
        
        path.curve(to: CGPoint(x: 248.9 * scale, y: 196.7 * scale),
                      controlPoint1: CGPoint(x: 240.8 * scale, y: 176.6 * scale),
                      controlPoint2: CGPoint(x: 251 * scale, y: 179.9 * scale))
        
        path.curve(to: CGPoint(x: 215.4 * scale, y: 237.5 * scale),
                      controlPoint1: CGPoint(x: 246.7 * scale, y: 214.3 * scale),
                      controlPoint2: CGPoint(x: 232.6 * scale, y: 234.2 * scale))
        
        path.curve(to: CGPoint(x: 160.5 * scale, y: 214.9 * scale),
                      controlPoint1: CGPoint(x: 193.4 * scale, y: 241.6 * scale),
                      controlPoint2: CGPoint(x: 186 * scale, y: 215.1 * scale))
        
        path.curve(to: CGPoint(x: 92.2 * scale, y: 250.6 * scale),
                      controlPoint1: CGPoint(x: 129.5 * scale, y: 214.7 * scale),
                      controlPoint2: CGPoint(x: 119.7 * scale, y: 253.9 * scale))
        
        path.curve(to: CGPoint(x: 54.9 * scale, y: 215.8 * scale),
                      controlPoint1: CGPoint(x: 74.9 * scale, y: 248.6 * scale),
                      controlPoint2: CGPoint(x: 60 * scale, y: 230.8 * scale))
        
        path.curve(to: CGPoint(x: 51 * scale, y: 171.3 * scale),
                      controlPoint1: CGPoint(x: 48.9 * scale, y: 198.6 * scale),
                      controlPoint2: CGPoint(x: 57.8 * scale, y: 191 * scale))
        
        path.close()
        
        return path.cgPath
    }
}
