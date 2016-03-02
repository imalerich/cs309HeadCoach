//
//  HCUser.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

class HCUser: NSObject {

    /// Primary key for this user to be used for API calls.
    internal var id = 0

    /// The users account name.
    internal var name = ""

    /// The date this user registered with the service (UNIX).
    internal var reg_date = 0

    /// Initialize with data retrieved from the 
    /// HeadCoach API.
    init(json: Dictionary<String, AnyObject>) {
        id = json["id"] as! Int
        name = json["name"] as! String
        reg_date = json["reg_date"] as! Int
    }
}
