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

    /// Use the 'login' parameter to set this property.
    /// Use this property with this data providers calls to
    /// perform actions on behalf of the user.
    var user = HCUser()

    /// The root API address for the HeadCoach servince.
    /// http://localhost/ can be used for testing new changes
    /// to the server. Otherwise the CS309 server should be used.
    let api =
        "http://proj-309-08.cs.iastate.edu"
//        "http://localhost"

    // -------------------------------------------------------------------------------------
    // Network Requests - Utility Methods.
    // -------------------------------------------------------------------------------------

    /// Send a request to the server to create a new user in the database.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getUserID' call, provided the user knows their account name.
    internal func getUserID(userName: String, completion: (Bool, HCUser?) -> Void) {
        let url = "\(api)/users/get.php?name=\(userName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                // set the currently logged in user
                self.user = HCUser(json: json[0])
                completion(false, self.user)
            } else {
                completion(true, nil)
            }
        }
    }

    /// User Login method, this method expects the user to provide their 
    /// username (and if time permits password), their HCUser representation
    /// will then be stored in the 'user' property to be used in other API calls.
    internal func registerUser(userName: String, completion: (Bool) -> Void) {
        let url = "\(api)/users/create.php?name=\(userName)"

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
    internal func registerLeague(leagueName: String, drafting: String, completion: (Bool) -> Void) {
        let url = "\(api)/leagues/create.php?name=\(leagueName)&drafting=\(drafting)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Send a request to retrieve the HCLeague for
    /// the given league name. This HCLeague can be used to
    /// make additional API calls.
    internal func getLeagueID(leagueName: String, completion: (Bool, HCLeague?) -> Void) {
        let url = "\(api)/leagues/get.php?name=\(leagueName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                // there will only be one user for this call
                let league = HCLeague(json: json[0])
                completion(false, league)
            } else {
                completion(true, nil)
            }
        }
    }

    /// HeadCoach API call to retrieve all of the
    /// registered users that are registered with the
    /// HeadCoach service.
    internal func getAllUsers(completion: (Bool, [HCUser]) -> Void) {
        let url = "\(api)/users/get.php"

        Alamofire.request(.GET, url).responseJSON { response in
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
    internal func addUserToLeague(user: HCUser, league: HCLeague, completion: (Bool) -> Void) {
        let url = "\(api)/leagues/addUser.php?user=\(user.id)&league=\(league.id)"

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
    internal func getAllLeaguesForUser(user: HCUser, completion: (Bool, [HCLeague]) -> Void) {
        let url = "\(api)/leagues/getAllForUser.php?id=\(user.id)"

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
    internal func getAllUsersForLeague(league: HCLeague, completion: (Bool, [HCUser]) -> Void) {
        let url = "\(api)/leagues/getAllUsers.php?id=\(league.id)"

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

    /// Given league, draft the player in that league to the given user.
    /// The user must be a member of the input league and the player must be
    /// undrafted.
    internal func draftPlayerForUser(league: HCLeague, user: HCUser, player: HCPlayer, completion: (Bool) -> Void) {
        let url = "\(api)/draft/draftPlayerToUser.php?user=\(user.id)&league=\(league.id)&player=\(player.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Retrieves a list of all players in the given league.
    internal func getAllPlayersFromLeague(league: HCLeague, completion: (Bool, [HCPlayer]) -> Void) {
        let url = "\(api)/draft/getAllFromLeague.php?id=\(league.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var players = [HCPlayer]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    players.append(HCPlayer(json: item))
                }
            }

            completion(players.count == 0, players)
        }
    }

    /// Retrieves a list of players that are owned by the given user.
    internal func getAllPlayersForUserFromLeague(league: HCLeague, user: HCUser, completion: (Bool, [HCPlayer]) -> Void) {
        let url = "\(api)/draft/getAllFromLeague.php?id=\(league.id)&user=\(user.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var players = [HCPlayer]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    players.append(HCPlayer(json: item))
                }
            }

            completion(players.count == 0, players)
        }
    }
}
