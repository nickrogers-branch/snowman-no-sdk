//
//  SMSnowmanViewController.swift
//  Snowman
//
//  Created by Nick Rogers on 12/11/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 View controller for the snowman creation flow.
 
 This view controller manages the views and data for creating, viewing and sharing a snowman.
 */
class SMSnowmanViewController: UIViewController
{
    /// The background view for this snowman creation/viewing/sharing view controller.
    var backgroundView: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBlue
        view.alpha = 0.2
        return view
    }()
    
    /// The view used to edit a snowman for this snowman view controller.
    var snowmanEditView: SMSnowmanView =
    {
        let view = SMSnowmanView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The close button for this view controller.
    var closeButton: UIButton =
    {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        button.setTitleColor(UIColor.tertiaryLabel, for: .highlighted)
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Snowman"
        
        self.view.backgroundColor = UIColor.systemBackground
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(snowmanEditView)
        self.view.addSubview(closeButton)
        
        // Configure the layout with autolayout.
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        snowmanEditView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        snowmanEditView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        snowmanEditView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        snowmanEditView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        snowmanEditView.shareButton.addTarget(self, action: #selector(self.shareButtonPressed(_:)), for: .touchUpInside)
        
        closeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Add the available accessories manually for now.
        let hat = SMAccessory(name: "Hat",
                              id: nil,
                              image: "hat_snowman_full.png",
                              thumbnail: "hat_snowman_thumbnail.png",
                              type: .head)
        let baseballCap = SMAccessory(name: "Baseball cap",
                                      id: nil,
                                      image: "baseball_cap_snowman_full.png",
                                      thumbnail: "baseball_cap_snowman_thumbnail.png",
                                      type: .head)
        let beanie = SMAccessory(name: "Beanie",
                                 id: nil,
                                 image: "beanie_snowman_full.png",
                                 thumbnail: "beanie_snowman_thumbnail.png",
                                 type: .head)
        let scarf = SMAccessory(name: "Scarf",
                                id: nil,
                                image: "scarf_snowman_full.png",
                                thumbnail: "scarf_snowman_thumbnail.png",
                                type: .neck)
        let tie = SMAccessory(name: "Tie",
                              id: nil,
                              image: "tie_snowman_full.png",
                              thumbnail: "tie_snowman_thumbnail.png",
                              type: .neck)
        let bowTie = SMAccessory(name: "Bow tie",
                                 id: nil,
                                 image: "bow_tie_snowman_full.png",
                                 thumbnail: "bow_tie_snowman_thumbnail.png",
                                 type: .neck)
        let branchPin = SMAccessory(name: "Branch Pin",
                                    id: nil,
                                    image: "branch_pin_snowman_full.png",
                                    thumbnail: "branch_pin_snowman_thumbnail.png",
                                    type: .neck)
        
        snowmanEditView.addAccessory(hat)
        snowmanEditView.addAccessory(baseballCap)
        snowmanEditView.addAccessory(beanie)
        snowmanEditView.addAccessory(scarf)
        snowmanEditView.addAccessory(tie)
        snowmanEditView.addAccessory(bowTie)
        snowmanEditView.addAccessory(branchPin)
        
        // If there already exists a snowman (passed in from a deep link, for example) load him here.
        if let snowman = SMSession.shared.snowman
        {
            snowmanEditView.nameField.text = snowman.name
            
            if let accessories = snowman.accessories
            {
                for accessory in accessories
                {
                    snowmanEditView.setAccessory(accessory)
                }
            }
        }
        
        closeButton.addTarget(self, action: #selector(self.closeButtonPressed(_:)), for: .touchUpInside)
    }
    
    /// Handle sharing snowman when share button is pressed.
    @objc func shareButtonPressed(_ button: UIButton)
    {
    }
    
    /// Handle close button pressed.
    @objc func closeButtonPressed(_ button: UIButton)
    {
        self.dismiss(animated: true) {
        }
    }
}
