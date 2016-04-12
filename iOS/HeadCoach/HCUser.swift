//
//  HCUser.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

class HCUser: CustomStringConvertible {

    /// Primary key for this user to be used for API calls.
    internal var id = 0

    /// The users account name.
    internal var name = ""

    /// The date this user registered with the service (UNIX).
    internal var reg_date = 0

    /// String conversion for debug printing.
    var description: String {
        return "{\nid: \(id)\nname: \(name)\nreg_date: \(reg_date)\n}\n"
    }

    /// Initializes a bare user using only an id.
    /// This should only be used for passing to API
    /// calls, as the 'name' and 'reg_date' will be invalid.
    /// If you do not need these properties, this 'user' will
    /// valid for all API calls.
    init(id: Int) {
        self.id = id
    }

    /// Initializes a user with data stored
    /// in the NSUserDefaults
    init(id: Int, name: String, red_date: Int) {
        self.id = id
        self.name = name
        self.reg_date = red_date
    }

    /// Initialize with data retrieved from the 
    /// HeadCoach API.
    init(json: Dictionary<String, String>) {
        id = Int(json["id"]!)!
        name = json["user_name"]!
        reg_date = Int(json["reg_date"]!)!
    }

    /// Creates an empty user, any API call will fail
    /// with this user, as 0 is an invalid 'id'
    init() { }
}
