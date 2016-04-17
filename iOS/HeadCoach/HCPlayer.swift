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
    internal var position: Position = .DefensiveLine

    // PhotoURL for this player.
    internal var img = ""

    /// If false this player is currently active 
    /// and used in fantasy games, else the player
    /// is not. DO NOT EXPLICITLY CHANGE THIS VALUE!
    /// Use the approprate call in the data provider!
    internal var isOnBench = false

    /// The players fantasy data position category.
    /// This will either be ST, OFF, or DEF.
    internal var position_category = ""

    /// The FantasyData id for this player.
    /// This id should be used for FantasyData calls 
    /// only, and not for HeadCoach API calls.
    internal var fantasy_id = 0

    /// Initialize with data retrieved from the
    /// HeadCoach API.
    init(json: Dictionary<String, String>) {
        id = Int(json["id"]!)!
        name = json["name"]!
        img = json["img"]!
        user_id = Int(json["user_id"]!)!
        position_category = json["pos_cat"]!
        fantasy_id = Int(json["fd_id"]!)!
        isOnBench = Int(json["on_bench"]!)! == 1

        let pos = json["pos"]!
        position = HCPositionUtil.stringToPosition(pos)
    }
}
