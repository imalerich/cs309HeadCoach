//
//  HCLeague.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

class HCLeague: CustomStringConvertible {

    /// Primary key for this league to be used for API calls.
    internal var id = 0

    /// The name this league was created with.
    internal var name = ""

    /// Drafting format this league uses.
    internal var drafting_style = 0

    /// Array of HCUsers who particpate in this league.
    internal var users = [Int]()

    /// The current week number for this league.
    /// Possible values include:
    ///     0 - Preseason
    ///     [1-17] - Regular Season
    internal var week_number = 0

    /// String conversion for debug printing.
    var description: String {
        return "{\nid: \(id)\nname: \(name)\ndrafting_style: \(drafting_style)\n}\n"
    }

    /// Initializes a league from explicit data.
    /// This can be used when you need to store a league
    /// in the NSUserDefaults, as is done by the
    /// HCHeadCoachDataProvider.
    init(id: Int, name: String, drafting_style: Int, users: [Int]) {
        self.id = id
        self.name = name
        self.drafting_style = drafting_style
        self.users = users
    }

    /// Initialize with data retrieved from the
    /// HeadCoach API.
    init(json: Dictionary<String, String>) {
        id = Int(json["id"]!)!
        name = json["name"]!
        drafting_style = Int(json["drafting"]!)!
        week_number = Int(json["week"]!)!

        for i in 0...4 {
            // add all the users for this league
            let user = Int(json["member\(i)"]!)!
            if user > 0 {
                users.append(user)
            }
        }
    }
}
