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

    // -------------------------------------------------------------------------------------
    // Network Requests - Utility Methods.
    // -------------------------------------------------------------------------------------

    /// Send a request to the server to create a new user in the system.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getUserID' call, provided the user nows their account name.
    /// This method is asynchronous.
    internal func createNewUser(userName: String, completion: (Bool) -> Void) {
        let url = "http://localhost/users/create.php?name=\(userName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Send a request to the server to retrieve the userID for
    /// the given user name. This id will be necessary to make 
    /// additional API requests.
    /// This method is asynchronous.
    internal func getUserID(userName: String, completion: (Bool, HCUser?) -> Void) {
        let url = "http://localhost/users/get.php?name=\(userName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                // there will only be one user for this call
                let user = HCUser(json: json[0]);
                completion(false, user)
            } else {
                completion(true, nil)
            }
        }
    }

    /// Sample API call that retrieves all of the
    /// registered users that are registered with the
    /// HeadCoach service.
    /// This method is asynchronous.
    internal func getAllUsers(completion: (Bool, [HCUser]) -> Void) {
        Alamofire.request(.GET, "http://localhost/users/get.php").responseJSON { response in
            var users = [HCUser]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    users.append(HCUser(json: item))
                }
            }

            // request complete, return all users found in the database
            completion(users.count == 0, users)
        }
    }

    /// Loads a list of all of the leagues available in
    /// the HeadCoach Fantasy service.
    /// This method is asynchronous.
    internal func getAllLeaguesForUser(user: HCUser, completion: (Bool, [HCLeague]) -> Void) {
        let url = "http://localhost/leagues/getAllForUser.php?id=\(user.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var leagues = [HCLeague]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    leagues.append(HCLeague(json: item))
                }
            }

            completion(leagues.count == 0, leagues)
        }
    }
}
