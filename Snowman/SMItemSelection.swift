//
//  SMItemSelection.swift
//  Snowman
//
//  Created by Nick Rogers on 12/11/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 An enum representing clothing categories for this snowman.
 */
enum SMAccessoryCategory: String, Codable
{
    case head = "head"
    case neck = "neck"
    case feet = "feet"
}

/**
 A struct representing an accessory for this snowman.
 */
struct SMAccessory
{
    var name: String?
    var id: String?
    var image: String?
    var thumbnail: String?
    var type: SMAccessoryCategory = .head
}

// Make categories conform to the hashable protocol.
extension SMAccessory: Hashable
{
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(image)
    }
}

// Specify that accessories conform to the codable protocol.
extension SMAccessory: Codable {}

// Specify that snowman conforms to the codable protocol.
struct SMSnowman: Codable
{
    var name: String?
    var accessories: [SMAccessory]?
}
