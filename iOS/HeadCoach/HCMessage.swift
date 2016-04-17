//
//  HCMessage.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/15/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCMessage {

    /// Unique id for referencing this message. 
    /// This will not likely be needed for any of our calls.
    var id = 0

    /// The user this message is being sent to.
    var to = HCUser()

    /// The user this message was sent from.
    var from = HCUser()

    /// True if the user has seen this message.
    /// False if otherwise.
    /// To update this property in the database,
    /// user the 'readConversation' call of the HeadCoach API.
    var has_read = false

    /// The date this message was sent.
    /// It is specifically set when the database receives the 
    /// message in its 'sendMessage' API call.
    var time_stamp = NSDate()

    /// The meat and potatos of this class, 
    /// the actual message that was sent to the user.
    var message = ""

    /// Initialize a message with data retrieved from 
    /// the 'getMessages' API call.
    init(json: Dictionary<String, AnyObject>) {
        id = Int(json["id"] as! String)!
        to = HCUser(json: json["to_id"] as! Dictionary<String, String>)
        from = HCUser(json: json["from_id"] as! Dictionary<String, String>)
        has_read = Int(json["has_read"] as! String!) == 1
        time_stamp = NSDate(timeIntervalSince1970: Double(json["time_stamp"] as! String)!)
        message = json["msg"] as! String
    }

}
