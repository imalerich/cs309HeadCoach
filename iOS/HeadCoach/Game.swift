
import Foundation

class Game{
    var week: Int
    var opp: String
    var homeOrAway: String
    var passYds: Int
    var recYds: Int
    
    init(week: Int, opp:String, homeOrAway:String, passYds:Int, recYds:Int){
        self.week = week
        self.opp = opp
        self.homeOrAway = homeOrAway
        self.passYds = passYds
        self.recYds = recYds
    }
}