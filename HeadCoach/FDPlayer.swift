//
//  HCPlayer.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 3/2/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import RealmSwift


class FDPlayer: Object
{
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
    
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
   
    
}