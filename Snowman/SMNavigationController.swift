//
//  SMNavigationViewController.swift
//  Snowman
//
//  Created by Nick Rogers on 12/10/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 Navigation controller for snowman app.
 
 This is the root view controller for Snowman and loads the home view controller.
 */
class SMNavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    /// Load the home view controller here into the navigation hierarchy.
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let homeVC = SMHomeViewController()
        self.pushViewController(homeVC, animated: false)
    }
}
