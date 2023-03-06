//
//  SMSession.swift
//  Snowman
//
//  Created by Nick Rogers on 12/19/19.
//  Copyright © 2019 Nick Rogers. All rights reserved.
//

import UIKit

/**
 A representation of JSON loading errors.
 */
enum JSONLoadingError: Error
{
    case failedDataConversion
    case failedJSONConversion
}

/**
 Session object for this snowman app.
 
 The session singleton handles deep linking for this snowman app.
 */
class SMSession
{
    /// Shared session object (singleton).
    static let shared = SMSession()
    
    /// The snowman loaded for this session. Deep linked snowman goes here.
    var snowman: SMSnowman?
    
    private init() {}
    
    /// Use the session object to parse a snowman from a loaded JSON string.
    func loadSnowmanFromString(_ jsonString: String) throws -> SMSnowman
    {
        var decodedSnowman = SMSnowman()
        
        guard let jsonData = jsonString.data(using: .utf8)
            else { throw JSONLoadingError.failedDataConversion }
        
        if let dSnowman = try? JSONDecoder().decode(SMSnowman.self, from: jsonData)
        {
            decodedSnowman = dSnowman
        }
        
        return decodedSnowman
    }
    
    @available (*, deprecated, message: "Use Swift decoder to decode JSON")
    private func getAccessory(forItemName name: String) -> SMAccessory?
    {
        var accessory: SMAccessory?
        
        switch name
        {
        case "baseball_cap":
            accessory = SMAccessory(name: "Baseball Cap",
                                    id: nil,
                                    image: "baseball_cap_snowman_full.png",
                                    thumbnail: "baseball_cap_snowman_thumbnail.png",
                                    type: .head)
        case "normal_hat":
            accessory = SMAccessory(name: "Hat",
                                    id: nil,
                                    image: "hat_snowman_full.png",
                                    thumbnail: "hat_snowman_thumbnail.png",
                                    type: .head)
        case "beanie":
            accessory = SMAccessory(name: "Beanie",
                                    id: nil,
                                    image: "beanie_snowman_full.png",
                                    thumbnail: "beanie_snowman_thumbnail.png",
                                    type: .head)
        case "bow_tie":
            accessory = SMAccessory(name: "Bow Tie",
                                    id: nil,
                                    image: "bow_tie_snowman_full.png",
                                    thumbnail: "bow_tie_snowman_thumbnail.png",
                                    type: .neck)
        case "tie":
            accessory = SMAccessory(name: "Tie",
                                    id: nil,
                                    image: "tie_snowman_full.png",
                                    thumbnail: "tie_snowman_thumbnail.png",
                                    type: .neck)
        case "scarf":
            accessory = SMAccessory(name: "Scarf",
                                    id: nil,
                                    image: "scarf_snowman_full.png",
                                    thumbnail: "scarf_snowman_thumbnail.png",
                                    type: .neck)
        case "branch_pin":
            accessory = SMAccessory(name: "Pin",
                                    id: nil,
                                    image: "branch_pin_snowman_full.png",
                                    thumbnail: "branch_pin_snowman_thumbnail.png",
                                    type: .neck)
        default:
            break
        }
        
        return accessory
    }
}
