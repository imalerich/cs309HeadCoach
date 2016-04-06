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
    
    func getPlayerDetails(onCompletion: ServiceInstance){
        // Using Mitch's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": "fa953b83a78d44a1b054b0afbbdff57e"]
        Alamofire.request(.GET, "https://api.fantasydata.net/nfl/v2/JSON/Players", headers: headers)
            .responseJSON { response in
                do{
                let json:NSArray = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    for items in json{
                        let player = items as! NSDictionary
                        let temp = FDPlayer()
                        if let name = player["Name"] as? String{
                            temp.name = name
                        }
                        if let fname = player["FirstName"] as? String{
                            temp.firstName = fname
                        }
                        if let lname = player["LastName"] as? String{
                            temp.lastName = lname
                        }
                        if let photoURL = player["PhotoUrl"] as? String{
                            temp.photoURL = photoURL
                        }
                        if let id = player["PlayerID"] as? Int{
                            temp.id = id
                        }
                        if let team = player["Team"] as? String{
                            temp.team = team
                        }
                        if let position = player["Position"] as? String{
                            temp.position = position
                        }
                        if let number = player["Number"] as? Int{
                            temp.number = number
                        }
                        if let height = player["Height"] as? String{
                            temp.height = height
                        }
                        if let weight = player["Weight"] as? Int{
                            temp.weight = weight
                        }
                        if let status = player["CurrentStatus"] as? String{
                            temp.status = status
                        }
                        if let fantasyPosition = player["FantasyPosition"] as? String{
                            temp.fantasyPosition = fantasyPosition
                        }
                        if let age = player["Age"] as? Int{
                            temp.age = age
                        }
                        if let byeWeek = player["ByeWeek"] as? Int{
                            temp.byeWeek = byeWeek
                        }
                        if let byeWeek = player["ByeWeek"] as? Int{
                            temp.byeWeek = byeWeek

                        }
                        /*
                        if let adp = player["AverageDraftPosition"] as? {
                            temp.adp = adp
                        }
                        */
                        let realm = try! Realm()
                        try! realm.write{
                            realm.add(temp,update:true)
                        }
                    }
                    onCompletion("DONE")
                    
                }catch let caught{
                    print(caught)
                }
        
        }
    }
    
    func getTeamsForSeason(season : Int){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": "2ae4d2ad88ae486e8dd3004e4259e2f1"]
        Alamofire.request(.GET, "https://api.fantasydata.net/nfl/v2/JSON/Teams/\(season)", headers: headers)
            .responseJSON { response in
                do{
                    let json = response.result.value as! Array<Dictionary<String, AnyObject>>
                    for item in json {
                        // let stadiumDetails = item["StadiumDetails"] as! Dictionary<String, AnyObject>
                        let key = item["Key"] as! String
                        let fullName = item["FullName"] as! String
                        print("Key: \(key), Full Name: \(fullName)")
                        
                    }
                    
                } catch let caught{
                    print(caught)
                }
                
        }

    }
    
    func getPlayerStatsForPlayerID(id : Int){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": "2ae4d2ad88ae486e8dd3004e4259e2f1"]
        Alamofire.request(.GET, "https://api.fantasydata.net/nfl/v2/XML/PlayerSeasonStatsByPlayerID/2015/\(id)", headers: headers)
            .responseJSON { response in
                do{
                    let json:NSArray = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    for items in json{
                        // TODO - Parse JSON stats into model
                        print(items)
                    }
                    //onCompletion("DONE")
                    
                }catch let caught{
                    print(caught)
                }
                
        }
    }
    
    func getPlayerStatsForPlayerID(id : Int, handler: (Int, NSArray) -> Void){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": "fa953b83a78d44a1b054b0afbbdff57e"]
        Alamofire.request(.GET, "https://api.fantasydata.net/nfl/v2/JSON/PlayerSeasonStatsByPlayerID/2015/\(id)", headers: headers)
            .responseJSON { response in
                do{
                    let json:NSArray = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    handler(id, json)
                    print("done")
                    
                }catch let caught{
                    print(String(id))
                    print(caught)
                }
                
        }
    }
    
    func getCurrentSeason(){
        // Using Joe's subscription key
        let headers = ["Ocp-Apim-Subscription-Key": "2ae4d2ad88ae486e8dd3004e4259e2f1"]
        Alamofire.request(.GET, "https://api.fantasydata.net/nfl/v2/JSON/CurrentSeason", headers: headers)
            .responseJSON { response in
                
                    //TODO - fix unexpected output error - endianness?
                    let data = response.result.value as! Int
                    
                    // print(data)
                    //onCompletion("DONE")
                
                
        }
    }
    
    
    
    
}


