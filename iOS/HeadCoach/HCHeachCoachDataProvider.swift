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

    /// Private constant for bench related API calls.
    private let PLAYER_ACTIVE = 0
    /// Private constant for bench related API calls.
    private let PLAYER_BENCH = 1

    /// Name for the notification sent out when the user
    /// login changes.
    static let UserDidLogin = "UserDidLogin"
    /// Name for the notification sent out when the 'league'
    /// property is updated.
    static let LeagueDidUpdate = "LeagueDidUpdate"

    /// The root API address for the HeadCoach servince.
    /// http://localhost/ can be used for testing new changes
    /// to the server. Otherwise the CS309 server should be used.
    let api =
        "http://proj-309-08.cs.iastate.edu"
  //      "http://localhost"

    /// When the shared instance is first created,
    /// send a request to the server to update all of its
    /// internal schedule data, the server will NOT automatically
    /// update its data, as it expects this app to give it 
    /// arbitrary dates for debug purposes
    override init() {
        super.init()

        let url = "\(api)/schedule/update.php?week=5"
        Alamofire.request(.GET, url).responseJSON { response in }

        // make sure the curent league data is up to date
        if league != nil && league?.name != nil {
            getLeagueID((league?.name)!, completion: { (err, league) in
                self.league = league
            })
        }
    }

    // ------------------------------------
    // MARK: Account and League Management.
    // ------------------------------------

    /// Use the 'login' parameter to set this property.
    /// Use this property with this data providers calls to
    /// perform actions on behalf of the user.
    var user: HCUser? {
        get {
            let id = NSUserDefaults.standardUserDefaults().integerForKey("HC.USER.ID")
            let name = NSUserDefaults.standardUserDefaults().stringForKey("HC.USER.NAME")
            let reg_date = NSUserDefaults.standardUserDefaults().integerForKey("HC.USER.REG_DATE")
            let img_url = NSUserDefaults.standardUserDefaults().stringForKey("HC.USER.IMG_URL")

            if name == nil { return nil }
            return HCUser(id: id, name: name!, red_date: reg_date, img_url: img_url)
        }

        set(newUser) {
            if newUser == nil { return }

            NSUserDefaults.standardUserDefaults().setValue(newUser!.id,
                                                           forKey: "HC.USER.ID")
            NSUserDefaults.standardUserDefaults().setValue(newUser!.name,
                                                           forKey: "HC.USER.NAME")
            NSUserDefaults.standardUserDefaults().setValue(newUser!.reg_date,
                                                           forKey: "HC.USER.REG_DATE")
            NSUserDefaults.standardUserDefaults().setValue(newUser!.img_url,
                                                           forKey: "HC.USER.IMG_URL")
            NSUserDefaults.standardUserDefaults().synchronize()

            NSNotificationCenter.defaultCenter().postNotificationName(HCHeadCoachDataProvider.UserDidLogin, object: self)
        }
    }

    /// The league that the user is signed in to. 
    /// This value should be used for all calls within the UI that
    /// need to access a league. This value should ONLY be changed
    /// from the HCSettingViewController, explicitly by the user.
    var league: HCLeague? {
        get {
            let id = NSUserDefaults.standardUserDefaults().integerForKey("HC.LEAGUE.ID")
            let name = NSUserDefaults.standardUserDefaults().stringForKey("HC.LEAGUE.NAME")
            let drafting = NSUserDefaults.standardUserDefaults().integerForKey("HC.LEAGUE.DRAFTING")
            let users = NSUserDefaults.standardUserDefaults().arrayForKey("HC.LEAGUE.USERS")
            let week = NSUserDefaults.standardUserDefaults().integerForKey("HC.LEAGUE.WEEK")

            if name == nil { return nil }
            return HCLeague(id: id, name: name!, drafting_style: drafting, users: users as! [Int], week: week)
        }

        set(newLeague) {
            NSUserDefaults.standardUserDefaults().setValue(newLeague!.id,
                                                           forKey: "HC.LEAGUE.ID")
            NSUserDefaults.standardUserDefaults().setValue(newLeague!.name,
                                                           forKey: "HC.LEAGUE.NAME")
            NSUserDefaults.standardUserDefaults().setValue(newLeague!.drafting_style,
                                                           forKey: "HC.LEAGUE.DRAFTING")
            NSUserDefaults.standardUserDefaults().setValue(newLeague!.users,
                                                           forKey: "HC.LEAGUE.USERS")
            NSUserDefaults.standardUserDefaults().setValue(newLeague!.week_number,
                                                           forKey: "HC.LEAGUE.WEEK")
            NSUserDefaults.standardUserDefaults().synchronize()

            NSNotificationCenter.defaultCenter().postNotificationName(HCHeadCoachDataProvider.LeagueDidUpdate, object: self)
        }
    }

    /// Returns 'true' if the user is currently logged in.
    /// When the app starts, if this evaluate to false, we should
    /// present the login screen to the user.
    internal func isUserLoggedIn() -> Bool {
        return user != nil
    }

    /// Clears the user data from the NSUserDefaults.
    /// This will trigger a new login event the next time the
    /// user opens the application.
    internal func logoutUser() {
        NSUserDefaults.standardUserDefaults().setValue(0, forKey: "HC.USER.ID")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "HC.USER.NAME")
        NSUserDefaults.standardUserDefaults().setValue(0, forKey: "HC.USER.REG_DATE")

        NSUserDefaults.standardUserDefaults().setValue(0, forKey: "HC.LEAGUE.ID")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "HC.LEAGUE.NAME")
        NSUserDefaults.standardUserDefaults().setValue(0, forKey: "HC.LEAGUE.DRAFTING")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "HC.LEAGUE.USERS")
    }

    // -------------------------------------
    // MARK: User related network requests.
    // -------------------------------------

    /// Send a request to the server to create a new user in the database.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getUserID' call, provided the user knows their account name.
    internal func getUserID(userName: String, completion: (Bool, HCUser?) -> Void) {
        let url = "\(api)/users/get.php?name=\(userName)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                // set the currently logged in user
                if json.count > 0 {
                    self.user = HCUser(json: json[0])
                    completion(false, self.user)
                    return
                }
            }

            completion(true, nil)
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

    /// HeadCoach API call to retrieve all of the
    /// registered users that are registered with the
    /// HeadCoach service.
    internal func getAllUsers(completion: (Bool, [HCUser]) -> Void) {
        let url = "\(api)/users/get.php"

        Alamofire.request(.GET, url).responseJSON { response in
            var users = [HCUser]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    users.append(HCUser(json: item))
                }
            }

            // request complete, return all users found in the database
            completion(users.count == 0, users)
        }
    }

    /// This call will update the profile picture for the given user.
    /// Note: The HeadCoach service will not host this image, a link
    /// to an external image storage service (such as imgur) is expected
    /// to be used instead.
    internal func setUserProfileImage(user: HCUser, imgUrl: String, completion: (Bool) -> Void) {
        let img = imgUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let url = "\(api)/users/setUserImage.php?user=\(user.id)&img=\(img!)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    // ---------------------------------------
    // MARK: League related network requests.
    // ---------------------------------------

    /// Send a request to the server to create a new league in the database.
    /// The service will assign a unique id that can be retrieved with the
    /// 'getLeagueID' call, provided the user knows the league name.
    internal func registerLeague(leagueName: String, completion: (Bool) -> Void) {
        let url = "\(api)/leagues/create.php?name=\(leagueName)&drafting=\(1)"

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
            if let json = response.result.value as? Dictionary<String, String> {
                // there will only be one user for this call
                let league = HCLeague(json: json)
                completion(false, league)
            } else {
                completion(true, nil)
            }
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

    /// Creates a list of all available leagues in the
    /// HeadCoach service.
    internal func getAllLeagues(completion: (Bool, [HCLeague]) -> Void) {
        let url = "\(api)/leagues/getAllLeagues.php"

        Alamofire.request(.GET, url).responseJSON { response in
            var leagues = [HCLeague]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    leagues.append(HCLeague(json: item))
                }
            }

            completion(leagues.count == 0, leagues)
        }
    }

    /// Creates a list of all of the leagues available in
    /// the HeadCoach Fantasy service.
    internal func getAllLeaguesForUser(user: HCUser, completion: (Bool, [HCLeague]) -> Void) {
        let url = "\(api)/leagues/getAllLeagues.php?id=\(user.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var leagues = [HCLeague]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
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
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    users.append(HCUser(json: item))
                }
            }

            completion(users.count == 0, users)
        }
    }

    // ----------------------------------------
    // MARK: Drafting related network requests.
    // ----------------------------------------

    /// Given league, draft the player in that league to the given user.
    /// The user must be a member of the input league and the player must be
    /// undrafted.
    internal func draftPlayerForUser(league: HCLeague, user: HCUser, player: HCPlayer, completion: (Bool) -> Void) {
        let url = "\(api)/draft/draftPlayerToUser.php?user=\(user.id)&league=\(league.id)&player=\(player.id)"

        // check locally that the user_id is set to 0 (undrafted)
        // the server will do the same, but we would like to fail early if we can
        if player.user_id == user.id  {
            completion(false)
            return
        }

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Retrieves a list of all players in the given league.
    internal func getAllPlayersFromLeague(league: HCLeague,
                                          completion: (Bool, [HCPlayer]) -> Void) {
        let url = "\(api)/draft/getAllFromLeague.php?league=\(league.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var players = [HCPlayer]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    players.append(HCPlayer(json: item))
                }
            }

            completion(players.count == 0, players)
        }
    }

    /// Retrieves a list of players that are owned by the given user.
    internal func getAllPlayersForUserFromLeague(league: HCLeague, user: HCUser,
                                                 completion: (Bool, [HCPlayer]) -> Void) {
        let url = "\(api)/draft/getAllFromLeague.php?league=\(league.id)&user=\(user.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            var players = [HCPlayer]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    players.append(HCPlayer(json: item))
                }
            }

            completion(players.count == 0, players)
        }
    }

    // Retrieves a list of all the undrafted players in the input league.
    internal func getUndraftedPlayersInLeague(league: HCLeague, completion: (Bool, [HCPlayer]) -> Void) {
        let url = "\(api)/draft/getAllFromLeague.php?league=\(league.id)&user=\(0)"

        Alamofire.request(.GET, url).responseJSON { response in
            var players = [HCPlayer]()
            if let json = response.result.value as? Array<Dictionary<String, String>> {
                for item in json {
                    players.append(HCPlayer(json: item))
                }
            }

            completion(players.count == 0, players)
        }
    }

    /// Moves the current player from the 'active' state to the 'bench' state.
    /// If the user is currently in the 'bench' state this method will do nothing.
    /// This method will update the 'isOnBench' property of the input 'player'.
    internal func movePlayerToBench(player: HCPlayer, league: HCLeague,
                                    completion: (Bool) -> Void) {
        movePlayerToFromBench(player, league: league, state: PLAYER_BENCH, completion: completion)
    }

    /// Moves the current player from the 'bench' state to the 'active' state.
    /// If the user is currently in the 'active' state this method will do nothing.
    /// This method will update the 'isOnBench' property of the input 'player'.
    internal func movePlayerToActive(player: HCPlayer, league: HCLeague,
                                    completion: (Bool) -> Void) {
        movePlayerToFromBench(player, league: league, state: PLAYER_ACTIVE, completion: completion)
    }

    /// Private utility that performs a network request to move a player to
    /// and from the bench. To perform this action externally, use
    /// either the movePlayerToBench or movePlayerToActive to help
    /// keeep code readable.
    private func movePlayerToFromBench(player: HCPlayer, league: HCLeague,
                                       state: Int, completion: (Bool) -> Void) {
        // player is already in the given state
        if (state == 1) == player.isOnBench {
            completion(false)
            return
        }

        player.isOnBench = (state == 1)
        let url = "\(api)/draft/movePlayerToFromBench.php?league=\(league.id)&player=\(player.id)" +
            "&state=\(state)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                completion(json["error"] as! Bool)
            } else {
                completion(false)
            }
        }
    }

    /// Checks the users current draft and evaluates whether or not it is valid.
    /// If the users draft is invalid at the time of a scheduled game, they will
    /// recieve no points and forfeit the game (if the opposing player also has
    /// an invalid draft the game will be considered a draw).
    /// The completion block will take the format as follows:
    ///     Bool - Error: Whether or not the request completed succesfully.
    ///     Bool - Valid: Whether or not the draft is valid.
    ///     Dictionay<Position, Int> - remaining: For each 'Position', how many
    ///         remaining players are required, to be valid, each must be 0
    ///         with the exception of 'Bench' which may be anywhere between [0, 5]
    ///     Dictionary<Position, Int> - required: The number of required players in 
    ///         each position, with the exception of 'Bench' which represents the 
    ///         maximum numeber of players that may be on the bench at a given time.
    private func isUserDraftValid(league: HCLeague, user: HCUser,
                                  completion: (Bool, Bool,
                                Dictionary<Position, Int>?, Dictionary<Position, Int>?) -> Void) {
        let url = "\(api)/draft/isUsersDraftValid.php?league=\(league.id)&player=\(user.id)"

        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                let err = json["error"] as! Bool
                let valid = json["valid"] as! Bool
                let remaining = json["remaining"] as! Dictionary<String, Int>
                let required = json["required"] as! Dictionary<String, Int>

                completion(err, valid,
                    HCPositionUtil.dictStringToDictPosition(remaining),
                    HCPositionUtil.dictStringToDictPosition(required))

            } else {
                completion(false, false, nil, nil)
            }
        }
    }

    // ----------------------------------------
    // MARK: Schedule related network requests.
    // ----------------------------------------

    /// Retrieves a list of all the games currently available for
    /// the input league.
    internal func getFullScheduleForLeague(league: HCLeague,
                                          completion: (Bool, [HCGameResult]) -> Void) {
        let params = "league=\(league.id)"
        getScheduleForLeague(params, completion: completion)
    }

    /// Retrieves a list of all the games currently available for
    /// the input league, limited to the games the input user is 
    /// involved in.
    internal func getScheduleForUser(league: HCLeague, user: HCUser,
                                                 completion: (Bool, [HCGameResult]) -> Void) {
        let params = "league=\(league.id)&user=\(user.id)"
        getScheduleForLeague(params, completion: completion)
    }

    /// Utility method that performs the 'getScheduleForLeague' request for the given parameters.
    /// For use of this method externally use either the 'getFullScheduleForLeague' or the
    /// 'getScheduleForUser' call.
    private func getScheduleForLeague(params: String, completion: (Bool, [HCGameResult]) -> Void) {
        let url = "\(api)/schedule/getScheduleForLeague.php?\(params)"
        Alamofire.request(.GET, url).responseJSON { response in
            var games = [HCGameResult]()
            if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                for item in json {
                    games.append(HCGameResult(json: item))
                }
            }

            completion(games.count == 0, games)
        }
    }

    /// Gets the users current statistics for the current league.
    /// The object retrieved through the completion block will contain
    /// the users current rank, total score through the league, 
    /// and the total number of games that player has played.
    /// The numeber of wins/loses/draws is also included in the HCUserStats object.
    internal func getUserStats(user: HCUser, league: HCLeague, completion: (HCUserStats?) -> Void) {
        let url = "\(api)/schedule/getUserStats.php?league=\(league.id)&user=\(user.id)"
        Alamofire.request(.GET, url).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, Int> {
                completion(HCUserStats(user: user, json: json))
            }

            completion(nil);
        }
    }
}
