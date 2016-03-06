//
//  HCHeacCoachDataProvider.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import Alamofire

class HCHeadCoachDataProvider: NSObject {

    /// Global singleton instance for this class.
    static let sharedInstance = HCHeadCoachDataProvider()

    /// Sample API call that retrieves all of the
    /// registered users that are registered with the
    /// HeadCoach service.
    internal func getAllUsers() -> [HCUser] {
        var users = [HCUser]()

        Alamofire.request(.GET, "http://localhost/users/get.php").responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    users.append(HCUser(json: item))
                }
            }

            // output the data for debuging
            for user in users {
                print(user)
            }
        }

        return users
    }
}
