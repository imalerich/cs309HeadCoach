//
//  HCLeague.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

class HCLeague: NSObject {

    /// Primary key for this league to be used for API calls.
    internal var id = 0

    /// The name this league was created with.
    internal var name = ""

    /// Drafting format this league uses.
    internal var drafting_style = 0

    /// The date this league was created on (UNIX).
    internal var reg_date = 0

    /// Array of HCUsers who particpate in this league.
    internal var users = [Int]()

    /// Initialize with data retrieved from the
    /// HeadCoach API.
    init(json: Dictionary<String, AnyObject>) {
        id = json["id"] as! Int
        name = json["name"] as! String
        drafting_style = json["drafting"] as! Int
        reg_date = json["reg_date"] as! Int

        for i in 0...5 {
            // add all the users for this league
            let user = json["member\(i)"] as! Int
            if user > 0 {
                users.append(user)
            }
        }
    }
}
