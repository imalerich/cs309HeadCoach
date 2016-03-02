//
//  HCPlayer.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

class HCPlayer: NSObject {

    /// Primary key for this player.
    internal var id = 0

    /// The full name of this player.
    internal var name = ""

    /// The id of the user who has drafted this player.
    internal var user_id = 0

    /// The FantasyData id for this player.
    /// This id should be used for FantasyData calls 
    /// only, and not for HeadCoach API calls.
    internal var fantasy_id = 0

    /// Initialize with data retrieved from the
    /// HeadCoach API.
    init(json: Dictionary<String, AnyObject>) {
        id = json["id"] as! Int
        name = json["name"] as! String
        user_id = json["user_id"] as! Int
        fantasy_id = json["fd_id"] as! Int
    }
}
