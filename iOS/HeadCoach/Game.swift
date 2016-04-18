
import Foundation

class Game{
    var week: Int?
    var opp: String?
    var homeOrAway: String?
    var passYds: Int?
    var passTds: Int?
    var passInts: Int?
    var recYds: Int?
    var recTds: Int?
    var recInts: Int?
    var rushYds: Int?
    var rushTds: Int?
    var score: Int?
    var oppScore: Int?
    var pts: Float?
    var fg0to19: Int?
    var fg20to29:Int?
    var fg30to39:Int?
    var fg40to49:Int?
    var fg50plus:Int?
    var started:String?
    
    init(week: Int, opp:String, homeOrAway:String, passYds:Int, passTds:Int, passInts:Int, recYds:Int, recTds:Int, recInts:Int, rushYds:Int, rushTds:Int, score:Int, oppScore:Int, fg0to19:Int, fg20to29:Int, fg30to39:Int, fg40to49:Int, fg50plus:Int, started:Int){
        self.week = week
        self.opp = opp
        self.homeOrAway = homeOrAway
        self.passYds = passYds
        self.passTds = passTds
        self.passInts = passInts
        self.recYds = recYds
        self.recTds = recTds
        self.recInts = recInts
        self.rushYds = rushYds
        self.rushTds = rushTds
        self.score = score
        self.oppScore = oppScore
        self.pts = 21.80
        self.fg0to19 = fg0to19
        self.fg20to29 = fg20to29
        self.fg30to39 = fg30to39
        self.fg40to49 = fg40to49
        self.fg50plus = fg50plus
        if(started == 1){
            self.started = "Yes"
        }else{
            self.started = "No"
        }
    }
    
    init(json: Dictionary<String, AnyObject>){
        if let e = json["Week"] as? Int{
            self.week = e
        }
        if let e = json["Opponent"] as? String{
            self.opp = e
        }
        if let e = json["HomeOrAway"] as? String{
            self.homeOrAway = e
        }
        if let e = json["PassingYards"] as? Int{
            self.passYds = e
        }
        if let e = json["PassingTouchdowns"] as? Int{
            self.passTds = e
        }
        if let e = json["PassingInterceptions"] as? Int{
            self.passInts = e
        }
        if let e = json["ReceivingYards"] as? Int{
            self.recYds = e
        }
        if let e = json["ReceivingTouchdowns"] as? Int{
            self.recTds = e
        }
        if let e = json["ReceivingInterceptions"] as? Int{
            self.recInts = e
        }
        if let e = json["RushingYards"] as? Int{
            self.rushYds = e
        }
        if let e = json["RushingTouchdowns"] as? Int{
            self.rushTds = e
        }
        if let e = json["FieldGoalsMade0to19"] as? Int{
            self.fg0to19 = e
        }
        if let e = json["FieldGoalsMade20to29"] as? Int{
            self.fg20to29 = e
        }
        if let e = json["FieldGoalsMade30to39"] as? Int{
            self.fg30to39 = e
        }
        if let e = json["FieldGoalsMade40to49"] as? Int{
            self.fg40to49 = e
        }
        if let e = json["FieldGoalsMade50Plus"] as? Int{
            self.fg50plus = e
        }
        if let e = json["Started"] as? Int{
            if(e == 1){
                self.started = "Yes"
            }else{
                self.started = "No"
            }
        }
    }
}