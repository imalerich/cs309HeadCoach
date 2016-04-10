
import Foundation

class Game{
    var week: Int
    var opp: String
    var homeOrAway: String
    var passYds: Int
    var passTds: Int
    var passInts: Int
    var recYds: Int
    var recTds: Int
    var recInts: Int
    var rushYds: Int
    var rushTds: Int
    var score: Int
    var oppScore: Int
    var pts: Float
    var fg0to19: Int
    var fg20to29:Int
    var fg30to39:Int
    var fg40to49:Int
    var fg50plus:Int
    var started:String
    
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
}