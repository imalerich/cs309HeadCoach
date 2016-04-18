//
//  HCFantasyDataProvider.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class HCFantasyDataProvider{
    static let sharedInstance = HCFantasyDataProvider()
    typealias ServiceInstance = (String) -> Void

    let key = "2b7828ede774479883ac80def76b4d45"
    let api = "https://api.fantasydata.net/nfl/v2/JSON"
    
    func getPlayerDetails(onCompletion: ServiceInstance) {
        let headers = ["Ocp-Apim-Subscription-Key": key]
        let url = "\(api)/Players"

        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                    for item in json {
                        let realm = try! Realm()
                        try! realm.write{
                            realm.add(FDPlayer(json: item), update:true)
                    }
                }
            }
        }
    }

    func getFDPlayerFromHCPlayer(player: HCPlayer, completion: (FDPlayer) -> Void) {
        let headers = ["Ocp-Apim-Subscription-Key": key]
        let url = "\(api)/Player/\(player.fantasy_id)"

        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    completion(FDPlayer(json: json))
            }
        }
    }

    func getPlayerStatsForPlayerID(id : Int, handler: (Int, Array<AnyObject>) -> Void){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": key]
        let url = "\(api)/PlayerSeasonStatsByPlayerID/2015/\(id)"

        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? Array<AnyObject> {
                    handler(id, json)
                }

        }
    }

    func getPlayerStatsForPlayerID(id : Int, handler: (Dictionary<String, AnyObject>) -> Void){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": key]
        Alamofire.request(.GET, "\(api)/PlayerSeasonStatsByPlayerID/2015/\(id)", headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? Array<Dictionary<String, AnyObject>> {
                    for item in json{
                        handler(item)
                    }
                }

        }
    }

    func getGameData(forWeek week: Int, forPlayer playerId: Int, handler: (Int, Dictionary<String, AnyObject>) -> Void){
        let headers = ["Ocp-Apim-Subscription-Key" : key]
        let url = "\(api)/PlayerGameStatsByPlayerID/2015/\(String(week))/\(String(playerId))"

        Alamofire.request(.GET, url, headers: headers)
            .responseJSON{response in
                switch response.result {
                case .Success(let JSON):
                    let data = JSON as! Dictionary<String, AnyObject>
                    handler(week, data)

                case .Failure(let error):
                    print("Week \(week) game data request failed with error: \(error)")
                }
        }
    }
}
