//
//  SMSnowAnimationView.swift
//  Snowman
//
//  Created by Nick Rogers on 12/10/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 Snowflake animation view.
 
 The code to drive the snowflake animation is derived from https://github.com/sp71/SnowAnimationExample.
 */
class SMSnowAnimationView: UIView
{
    /// The background view for this snow effect animation view.
    var backgroundView = UIView()
    /// The animation view for this snow effect animation view. Snowflake animation happens here.
    var animationView = UIView()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.backgroundColor = UIColor.systemBlue
        backgroundView.alpha = 0.2
        
        self.addSubview(backgroundView)
        self.addSubview(animationView)
        
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        animationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(named: "snow_flake")?.cgImage
        flakeEmitterCell.scale = 0.06
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 40
        flakeEmitterCell.velocity = -40
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 10
        flakeEmitterCell.xAcceleration = 2
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0

        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: self.bounds.width / 2.0, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: self.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        
        animationView.layer.addSublayer(snowEmitterLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
