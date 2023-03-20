//
//  SMHomeViewController.swift
//  Snowman
//
//  Created by Nick Rogers on 12/10/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit
import BranchSDK


/**
 Home view controller for Snowman.
 
 The home view controller contains the landing page for Snowman. It loads the snowflake animations and handles opening the Snowman creation screen.
 */
class SMHomeViewController: UIViewController
{
    /// The snowflake animation view for Snowman's home screen.
    internal var snowFlakeView: SMSnowAnimationView =
    {
        let view = SMSnowAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    /// UIButton to load the snowman creation view.
    internal var makeButton: UIButton =
    {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.secondarySystemBackground
        button.setTitle("Make Snowman", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        button.setTitleColor(UIColor.quaternaryLabel, for: .highlighted)
        button.layer.cornerRadius = 11
        return button
    }()

    /// A user interaction tap gesture recognizer for this home view controller (currently unused).
    internal var userInteraction: UITapGestureRecognizer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.title = "Snowman"
        
        makeButton.addTarget(self, action: #selector(self.makeButtonPressed(_:)), for: .touchUpInside)
        
        self.view.addSubview(snowFlakeView)
        self.view.addSubview(makeButton)
        self.setupEventListener()
        
        snowFlakeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        snowFlakeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        snowFlakeView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        snowFlakeView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        makeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        makeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        makeButton.widthAnchor.constraint(equalToConstant: 175).isActive = true
        makeButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        Branch.getInstance().setIdentity(NSUserName())
    }
    
    @objc func makeButtonPressed(_ button: UIButton)
    {
        let vc = SMSnowmanViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,
                     animated: true,
                     completion: nil)
    }
}
