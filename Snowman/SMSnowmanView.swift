//
//  SMSnowmanView.swift
//  Snowman
//
//  Created by Nick Rogers on 12/11/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 Header views for accessories. Was used with collection views before table views were implemented.
 */
@available (*, deprecated, message: "Use tableview instead.")
class SMAccessoryCollectionHeaderView: UICollectionReusableView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemIndigo
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
}

/**
 The snowman view for this snowman app.
 
 This view is used to view and edit snowmen.
 */
class SMSnowmanView: UIView
{
    /// List the selected accessories.
    var selectedAccessories: [SMAccessory]
    {
        get
        {
            return self.selectedAccessoriesByCategory.map { $0.value }
        }
    }
    
    /// Share button for this snowman view.
    var shareButton: UIButton =
    {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = UIColor.systemFill
        return button
    }()
    
    /// Name field for this snowman view.
    var nameField: UITextField =
    {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        field.placeholder = "Name"
        field.textAlignment = .center
        field.returnKeyType = .done
        return field
    }()
    
    /// The base image for this snowman. Currently, this contains the main body of the snowman.
    private var baseImageView: UIImageView =
    {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    /// A tableview for displaying and selecting accessory items.
    private var accessorySelectionTableView: UITableView =
    {
        let tbv = UITableView(frame: .zero, style: .plain)
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.register(UITableViewCell.self, forCellReuseIdentifier: "cell_id")
        tbv.backgroundColor = UIColor.secondarySystemFill
        return tbv
    }()
    
    /// The view for displaying content to this snowman view. All accessory image views get placed into this container.
    private var snowmanContentView: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Array of image views holding the accessories.
    private var accessoryImageViews = [UIImageView]()
    /// List of accessories by category.
    private var accessoriesByCategory = [SMAccessoryCategory : [SMAccessory]]()
    /// A mapping of category by index. Used for looking up category associated with a row (index) in the table view.
    private var categoriesByIndex = [Int : SMAccessoryCategory]()
    /// A mapping of indices by category. Used for looking up index of a category.
    private var indexByCategory = [SMAccessoryCategory : Int]()
    /// The number of categories.
    private var numberOfCategories = 0
    /// The selected accessories by category.
    private var selectedAccessoriesByCategory = [SMAccessoryCategory : SMAccessory]()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // Load the base view (the body of the snowman) here.
        baseImageView.image = UIImage(named: "Snowman.png")
        
        // Set the delegate for the name field to handle naming the snowman.
        nameField.delegate = self
        
        // Configure the data source and delegate for the accessory selection table view.
        accessorySelectionTableView.dataSource = self
        accessorySelectionTableView.delegate = self
        
        // Add the views to the view hierarchy (from this view).
        self.addSubview(accessorySelectionTableView)
        self.addSubview(snowmanContentView)
        snowmanContentView.addSubview(baseImageView)
        self.addSubview(shareButton)
        self.addSubview(nameField)
        
        // Configure autolayout for these views.
        
        accessorySelectionTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        accessorySelectionTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        accessorySelectionTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        accessorySelectionTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        
        snowmanContentView.bottomAnchor.constraint(equalTo: accessorySelectionTableView.topAnchor).isActive = true
        snowmanContentView.topAnchor.constraint(equalTo: self.nameField.bottomAnchor).isActive = true
        snowmanContentView.widthAnchor.constraint(equalTo: baseImageView.heightAnchor, multiplier: 1/1.75).isActive = true
        snowmanContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        baseImageView.bottomAnchor.constraint(equalTo: snowmanContentView.bottomAnchor, constant: 15).isActive = true
        baseImageView.topAnchor.constraint(equalTo: self.snowmanContentView.topAnchor).isActive = true
        baseImageView.widthAnchor.constraint(equalTo: baseImageView.heightAnchor, multiplier: 1/1.75).isActive = true
        baseImageView.centerXAnchor.constraint(equalTo: snowmanContentView.centerXAnchor).isActive = true
        
        shareButton.bottomAnchor.constraint(equalTo: accessorySelectionTableView.topAnchor, constant: -10).isActive = true
        shareButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    /// Add an accessory to this snowman view.
    func addAccessory(_ accessory: SMAccessory)
    {
        // If this category hasn't been added yet, create it.
        if accessoriesByCategory[accessory.type] == nil
        {
            accessoriesByCategory[accessory.type] = [SMAccessory]()
            categoriesByIndex[numberOfCategories] = accessory.type
            indexByCategory[accessory.type] = numberOfCategories
            numberOfCategories += 1
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            snowmanContentView.addSubview(imageView)
            
            accessoryImageViews.append(imageView)
            
            imageView.bottomAnchor.constraint(equalTo: baseImageView.bottomAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: baseImageView.topAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: baseImageView.widthAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: baseImageView.centerXAnchor).isActive = true
        }
        
        accessoriesByCategory[accessory.type]!.append(accessory)
    }
    
    /// Set accessory for this snowman in this snowman view.
    func setAccessory(_ accessory: SMAccessory)
    {
        // If the accessory type doesn't exist yet, add it.
        if indexByCategory[accessory.type] == nil
        {
            addAccessory(accessory)
        }
        
        guard let imageName = accessory.image
            else { return }
        guard let indexForCategory = indexByCategory[accessory.type]
            else { return }
        
        let imageView = accessoryImageViews[indexForCategory]
        imageView.image = UIImage(named: imageName)
        selectAccessory(accessory)
    }
    
    /// Get the accessory associated with an index path (section and row).
    private func accessoryForIndexPath(_ indexPath: IndexPath) -> SMAccessory?
    {
        guard let categoryIndex = categoriesByIndex[indexPath.section]
            else { return nil }
        guard let categoryAccessories = accessoriesByCategory[categoryIndex]
            else { return nil }
        return categoryAccessories[indexPath.row]
    }
    
    /// Handle selection of an accessory.
    private func selectAccessory(_ accessory: SMAccessory)
    {
        selectedAccessoriesByCategory[accessory.type] = accessory
    }
}

/**
 The table view for displaying accessories.
 */
extension SMSnowmanView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return accessoriesByCategory[categoriesByIndex[section]!]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return categoriesByIndex.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        guard let category = categoriesByIndex[section]
            else { return nil }
        return category.rawValue.capitalized
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath)
        
        guard let accessory = accessoryForIndexPath(indexPath)
            else { return cell }
        
        cell.textLabel?.text = accessory.name
        cell.backgroundColor = .clear
        if let imageName = accessory.thumbnail
        {
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell
    }
}

extension SMHomeViewController
{
    func setupEventListener()
    {
        self.userInteraction = UITapGestureRecognizer(target: self, action: #selector(self.celebration))
        self.userInteraction?.numberOfTapsRequired = 2
        self.userInteraction?.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(userInteraction!)
    }
}

/**
 Handle the delegate method for selecting values in the accessory table view.
 */
extension SMSnowmanView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Deselect the row.
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the accessory for this index path.
        guard let accessory = accessoryForIndexPath(indexPath)
            else { return }
        // Load the name of the image for this accessory.
        guard let imageName = accessory.image
            else { return }
        
        // Get the image view for this corresponding accessory.
        let imageView = accessoryImageViews[indexPath.section]
        
        // Set the image equal to the correct image for the selected accessory.
        imageView.image = UIImage(named: imageName)
        
        // Select this accessory.
        selectAccessory(accessory)
    }
}

extension SMHomeViewController
{
    @objc func celebration()
    {
        let supplementalBackgroundVC = UIViewController()
        supplementalBackgroundVC.isModalInPresentation = false
        let supplementalLabel = UILabel()
        supplementalLabel.text = "celebration".uppercased()
        supplementalLabel.font = UIFont.systemFont(ofSize: 36, weight: .black)
        supplementalLabel.textColor = UIColor.systemPink
        supplementalLabel.translatesAutoresizingMaskIntoConstraints = false
        supplementalBackgroundVC.view.addSubview(supplementalLabel)
        supplementalLabel.centerXAnchor.constraint(equalTo: supplementalBackgroundVC.view.centerXAnchor).isActive = true
        supplementalLabel.centerYAnchor.constraint(equalTo: supplementalBackgroundVC.view.centerYAnchor).isActive = true
        supplementalBackgroundVC.view.backgroundColor = UIColor.systemBlue
        self.present(supplementalBackgroundVC, animated: false) {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: [.autoreverse, .repeat],
                           animations: {
                            supplementalBackgroundVC.view.backgroundColor = UIColor.systemPink
                            supplementalLabel.textColor = UIColor.systemBlue
            }) { (completed) in
            }
        }
    }
}

/// Handle the snowman text field delegate.
extension SMSnowmanView: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
