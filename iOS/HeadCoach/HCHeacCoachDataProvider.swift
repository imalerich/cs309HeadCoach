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

    /// Send a request to the server to create a new user in the database.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getUserID' call, provided the user knows their account name.
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

    /// Send a request to the server to create a new league in the database.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getLeagueID' call, provided the user knows the league name.
    /// This method eqecutes asynchronously.
    internal func createNewLeague(leagueName: String, drafting: String, completion: (Bool) -> Void) {
        let url = "http://localhost/leagues/create.php?name=\(leagueName)&drafting=\(drafting)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Send a request to the server to retrieve the HCUser for
    /// the given user name. This user will be necessary to make
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

    /// Send a request to retrieve the HCLeague for
    /// the given league name. This HCLeague can be used to
    /// make additional API calls.
    /// This method is asynchronous.
    internal func getLeagueID(leagueName: String, completion: (Bool, HCLeague?) -> Void) {
        let url = "http://localhost/leagues/get.php?name=\(leagueName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                // there will only be one user for this call
                let league = HCLeague(json: json[0]);
                completion(false, league)
            } else {
                completion(true, nil)
            }
        }
    }

    /// HeadCoach API call to retrieve all of the
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

    /// Adds the given user as a member of the given league.
    /// This call will fail if:
    ///     * The user is already a member of the given league.
    ///     * There are no member slots remaining in the given league.
    ///     * The given user or league does not exist.
    /// This method is asynchronous.
    internal func addUserToLeague(user: HCUser, league: HCLeague, completion: (Bool) -> Void) {
        let url = "http://localhost/leagues/addUser.php?user=\(user.id)&league=\(league)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Creates a list of all of the leagues available in
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

    /// Creates a list of all the users currently registered to the
    /// HeadCoach Fantasy service.
    /// This method is asynchronous.
    internal func getAllUsersForLeague(league: HCLeague, completion: (Bool, [HCUser]) -> Void) {
        let url = "http://localhost/leagues/getAllUsers.php?id=\(league.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var users = [HCUser]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    users.append(HCUser(json: item))
                }
            }

            completion(users.count == 0, users)
        }
    }
}
