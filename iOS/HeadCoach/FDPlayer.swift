//
//  HCPlayer.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import RealmSwift

class FDPlayer: Object {
    dynamic var name:String = ""
    dynamic var team:String = ""
    dynamic var id: Int = 0
    dynamic var status: String = ""
    dynamic var position: String = ""
    dynamic var fantasyPosition: String = ""
    dynamic var headCoachID:String = ""
    dynamic var number: Int = 0
    dynamic var college:String = ""
    dynamic var photoURL:String = ""
    dynamic var height:String = ""
    dynamic var weight:Int = 0
    dynamic var draftYear:Int = 0
    dynamic var age:Int = 0
    dynamic var byeWeek:Int = 0
    dynamic var firstName:String = ""
    dynamic var lastName:String = ""

    override static func primaryKey() -> String?{
        return "id"
    }
    
    enum SortType: String{
        case AlphaAZ = "A-Z"
        case AlphaZA = "Z-A"
    }
    
    enum PositionFilterType: String {
        case All = "All"
        case QB = "QB"
        case TE = "TE"
        case RB = "RB"
        case WR = "WR"
        case K = "K"
    }

    init(json: Dictionary<String, AnyObject>) {
        super.init()

        if let name = json["Name"] as? String {
            self.name = name
        }
        
        if let firstName = json["FirstName"] as? String {
            self.firstName = firstName
        }

        if let lastName = json["LastName"] as? String {
            self.lastName = lastName
        }

        if let photoURL = json["PhotoUrl"] as? String {
            self.photoURL = photoURL
        }

        if let id = json["PlayerID"] as? Int {
            self.id = id
        }

        if let team = json["Team"] as? String {
            self.team = team
        }

        if let position = json["Position"] as? String {
            self.position = position
        }

        if let number = json["Number"] as? Int {
            self.number = number
        }

        if let height = json["Height"] as? String {
            self.height = height
        }

        if let weight = json["Weight"] as? Int {
            self.weight = weight
        }

        if let status = json["CurrentStatus"] as? String {
            self.status = status
        }

        if let fantasyPosition = json["FantasyPosition"] as? String {
            self.fantasyPosition = fantasyPosition
        }

        if let age = json["Age"] as? Int {
            self.age = age
        }

        if let byeWeek = json["ByeWeek"] as? Int {
            self.byeWeek = byeWeek
        }
    }
    
    required init() {
        super.init()
    }
}