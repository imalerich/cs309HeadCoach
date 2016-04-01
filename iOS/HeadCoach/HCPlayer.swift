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

    /// The players fantasy data position.
    /// A team must be composed of a set number
    /// of players to fill each required position.
    internal var position = ""

    /// The players fantasy data position category.
    /// This will either be ST, OFF, or DEF.
    internal var position_category = ""

    /// The FantasyData id for this player.
    /// This id should be used for FantasyData calls 
    /// only, and not for HeadCoach API calls.
    internal var fantasy_id = 0

    /// Initialize with data retrieved from the
    /// HeadCoach API.
    init(json: Dictionary<String, AnyObject>) {
        id = Int(json["id"] as! String)!
        name = json["name"] as! String
        user_id = Int(json["user_id"] as! String)!
        position = json["pos"] as! String
        position_category = json["pos_cat"] as! String
        fantasy_id = Int(json["fd_id"] as! String)!
    }
}
