//
//  HCUserStats.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/7/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCUserStats: NSObject {

    /// The current rank of this user in the league.
    /// The default value of 0 has no meaning (ie. unranked).
    /// The range of this value may be anywhere from [1-5]
    /// 1 being the highest rank, and 5 being in last place.
    internal var rank = 0

    /// The total score for this player across all
    /// of their games.
    internal var total_score = 0

    /// Total number of wins for this user.
    internal var wins = 0

    /// Total number of loses for this user.
    internal var loses = 0

    /// Total number of draws for this user.
    internal var draws = 0

    /// Computes the total number of games by adding
    /// the number of wins, loses, and draws.
    internal var games: Int {
        get {
            return wins + loses + draws
        }
    }

    /// Initializes this class with data retrieved from the
    /// 'getUserStats' call from the HCHeadCoachDataProvider.
    init(json: Dictionary<String, Int>) {
        rank = json["rank"]!
        total_score = json["score"]!
        wins = json["wins"]!
        loses = json["loses"]!
        draws = json["draws"]!
    }
}
