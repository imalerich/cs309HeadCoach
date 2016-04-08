//
//  HCGameResult.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/7/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCGameResult: CustomStringConvertible {

    /// Primary key for this HCGameResult, this will probably never be needed.
    internal var id = 0

    /// Tuple containing the two user ID's involved in this game.
    internal var users = (0, 0)

    /// Tuple containing the scores of each player in this match.
    /// The ordering of the scores corresponds to the ordering of
    /// the data in the 'users' property.
    internal var scores = (0, 0)

    /// The week number for this game.
    /// Possible value for this value are as follows:
    ///     0 - Pre Season
    ///     [1-17] - Regular Season
    internal var week = 0

    /// Whether or not this game is completed or not.
    /// If it is not completed the scores will be 0 and
    /// should not be shown to the user. In the current 
    /// implementation of the API, this value will 
    /// always be 'true' for a valid HCGameResult.
    internal var completed = false

    /// String conversion for debug printing.
    var description: String {
        return "{\nid: \(id)\nusers: \(users)\nscores: \(scores)\nweek: \(week)" +
            "\ncompleted: \(completed)\n}\n"
    }

    /// Initializes an HCGameResult with data returned
    /// by the HeadCoach API.
    init(json: Dictionary<String, String>) {
        id = Int(json["id"]!)!
        let user0 = Int(json["user_id_0"]!)!
        let user1 = Int(json["user_id_1"]!)!
        users = (user0, user1)
        let score0 = Int(json["score_0"]!)!
        let score1 = Int(json["score_1"]!)!
        scores = (score0, score1)
        week = Int(json["week"]!)!
        completed = Int(json["completed"]!)! == 1
    }

    /// Creates an empty game result, any API call will fail
    /// with this HCGameResult
    init() { }
}
