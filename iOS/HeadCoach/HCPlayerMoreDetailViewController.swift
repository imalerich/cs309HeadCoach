
import Foundation
import UIKit
import SnapKit
import Alamofire

class HCPlayerMoreDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    let statPickerData = ["General", "Scoring", "Passing", "Receiving", "Defense", "Rushing", "Kicking", "Punting"]
    var currentCat: String!
    
    var statistics: Dictionary<String, Dictionary<String, String>>!
    var generalStats: [String]!
    var scoringStats: [String]!
    var passingStats: [String]!
    var receivingStats: [String]!
    var defensiveStats: [String]!
    var rushStats: [String]!
    var kickStats: [String]!
    var puntStats: [String]!
    
    var fdplayer: FDPlayer!
    var hcplayer: HCPlayer!
    var detail: PlayerDetailView!
    var games = [Game]()
    
    convenience init(forHCPlayer player: HCPlayer){
        self.init()
        self.hcplayer = player
    }
    
    convenience init(forFDPlayer player: FDPlayer){
        self.init()
        self.fdplayer = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        if fdplayer != nil{
            build(fdplayer)
        }else{
            HCFantasyDataProvider.sharedInstance.getPlayerDetailsForPlayerID(hcplayer.fantasy_id, handler: HCPlayerMoreDetailController.build(self))
        }
    }
    
    func build(player: FDPlayer){
        detail = PlayerDetailView(player: player, delegate: self)
        view.addSubview(detail)
        detail.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        detail.draftButton.addTarget(detail, action: #selector(HCPlayerMoreDetailController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        requestPlayerStats(fdplayer.id)
        requestGameData()
    }
    
    func requestGameData(){
        self.games = [Game]()
        for index in 0...20{
            let headers = ["Ocp-Apim-Subscription-Key" : "fa953b83a78d44a1b054b0afbbdff57e"]
            let url = "http://api.fantasydata.net/nfl/v2/JSON/PlayerGameStatsByPlayerID/2015/" + String(index) + "/" + String(fdplayer.id)
            print(url)
            Alamofire.request(.GET, url, headers: headers)
                .responseJSON{response in
                    switch response.result {
                    case .Success(let JSON):
                        let data = JSON as! Dictionary<String, AnyObject>
                        let game = Game(json: data)
                        self.games.append(game)
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
            }
        }
    }
    
    func requestPlayerStats(playerID: Int){
        HCFantasyDataProvider.sharedInstance.getPlayerStatsForPlayerID(playerID, handler: HCPlayerMoreDetailController.parseStatisticalData(self))
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === detail.draftButton {
            let vc = HCTradeDetailViewController()
            vc.player1 = fdplayer
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView === detail.statTable){
            return statsForCategory(currentCat).count
        }
        else{ return 1 }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if (cell != nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1,
                                   reuseIdentifier:"cell")
        }
        let stat = statistics[currentCat]
        if(stat!.count > 0){
            cell.textLabel!.text = statsForCategory(currentCat)[indexPath.row]
            cell.detailTextLabel!.text = stat![statsForCategory(currentCat)[indexPath.row]]
            cell.backgroundColor = UIColor.whiteColor()
            cell.setNeedsLayout()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statPickerData.capacity
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCat = statPickerData[row]
        detail.statCatButton.setTitle(currentCat, forState: UIControlState.Normal)
        detail.statTable.reloadData()
        UIView.animateWithDuration(0.5, animations: {
            self.detail.statCatPicker.alpha = 0.0
            }, completion: { b in
                if(b){
                    self.detail.statCatPicker.hidden = true
                }
        })
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: statPickerData[row])
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func statsForCategory(cat: String) ->[String]{
        switch(cat){
        case "General": return generalStats
        case "Scoring": return scoringStats
        case "Passing": return passingStats
        case "Receiving": return receivingStats
        case "Defense": return defensiveStats
        case "Rushing": return rushStats
        case "Kicking": return kickStats
        case "Punting": return puntStats
        default: return generalStats
        }
    }
    
    func parseStatisticalData(json: Dictionary<String, AnyObject>) {
        statistics = Dictionary<String, Dictionary<String, String>>()
        
        var general = Dictionary<String, String>()
        generalStats = [String]()
        if let g = json["Played"]{
            generalStats.append("Games Played")
            general.updateValue(String(g as! Int), forKey: "Games Played")
        }
        if let g = json["Started"]{
            generalStats.append("Games Started")
            general.updateValue(String(g as! Int), forKey: "Games Started")
        }
        if let g = json["Activated"]{
            generalStats.append("Games Activated")
            general.updateValue(String(g as! Int), forKey: "Games Activated")
        }
        if let g = json["Tackles"]{
            generalStats.append("Tackles")
            general.updateValue(String(g as! Int), forKey: "Tackles")
        }
        if let g = json["Touchdowns"]{
            generalStats.append("Touchdowns")
            general.updateValue(String(g as! Int), forKey: "Touchdowns")
        }
        if let g = json["FieldGoalsMade"]{
            generalStats.append("Field Goals Made")
            general.updateValue(String(g as! Int), forKey: "Field Goals Made")
        }
        statistics.updateValue(general, forKey: "General")
        print("general " + String(general.count))
        
        var scoring = Dictionary<String, String>()
        scoringStats = [String]()
        if let s = json["Touchdowns"]{
            scoringStats.append("Touchdowns")
            scoring.updateValue(String(s as! Int), forKey: "Touchdowns")
        }
        if let s = json["FieldGoalsAttempted"]{
            scoringStats.append("Field Goals Attempted")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals Attempted")
        }
        if let s = json["FieldGoalsMade"]{
            scoringStats.append("Field Goals Made")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals Made")
        }
        if let s = json["FieldGoalsLongestMade"]{
            scoringStats.append("Longest Field Goal")
            scoring.updateValue(String(s as! Int), forKey: "Longest Field Goal")
        }
        if let s = json["ExtraPointsMade"]{
            scoringStats.append("Extra Points Made")
            scoring.updateValue(String(s as! Int), forKey: "Extra Points Made")
        }
        if let s = json["FieldGoalsMade0to19"]{
            scoringStats.append("Field Goals 0-19 yds.")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals 0-19 yds.")
        }
        if let s = json["FieldGoalsMade20to29"]{
            scoringStats.append("Field Goals 20-29 yds.")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals 20-29 yds.")
        }
        if let s = json["FieldGoalsMade30to39"]{
            scoringStats.append("Field Goals 30-39 yds.")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals 30-39 yds.")
        }
        if let s = json["FieldGoalsMade40to49"]{
            scoringStats.append("Field Goals 40-49 yds.")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals 40-49 yds.")
        }
        if let s = json["FieldGoalsMade50Plus"]{
            scoringStats.append("Field Goals 50+ yds.")
            scoring.updateValue(String(s as! Int), forKey: "Field Goals 50+ yds.")
        }
        statistics.updateValue(scoring, forKey: "Scoring")
        
        var passing = Dictionary<String, String>()
        passingStats = [String]()
        if let p1 = json["PassingAttempts"]{
            passingStats.append("Pass Attempts")
            passing.updateValue(String(p1 as! Int), forKey: "Pass Attempts")
        }
        if let p1 = json["PassingCompletions"]{
            passingStats.append("Pass Completions")
            passing.updateValue(String(p1 as! Int), forKey: "Pass Completions")
        }
        if let p1 = json["PassingCompletionPercentage"]{
            passingStats.append("Pass Completion %")
            passing.updateValue(String(p1 as! Float), forKey: "Pass Completion %")
        }
        if let p1 = json["PassingTouchdowns"]{
            passingStats.append("Passing Touchdowns")
            passing.updateValue(String(p1 as! Int), forKey: "Passing Touchdowns")
        }
        if let p1 = json["PassingYards"]{
            passingStats.append("Passing Yards")
            passing.updateValue(String(p1 as! Int), forKey: "Passing Yards")
        }
        if let p1 = json["PassingYardsPerAttempts"]{
            passingStats.append("Passing Yards/Attempt")
            passing.updateValue(String(p1 as! Float), forKey: "Passing Yards/Attempt")
        }
        if let p1 = json["PassingYardsPerCompletion"]{
            passingStats.append("Passing Yards/Completion")
            passing.updateValue(String(p1 as! Float), forKey: "Passing Yards/Completion")
        }
        if let p1 = json["PassingInterceptions"]{
            passingStats.append("Passing Interceptions")
            passing.updateValue(String(p1 as! Int), forKey: "Passing Interceptions")
        }
        if let p1 = json["PassingRating"]{
            passingStats.append("Passing Rating")
            passing.updateValue(String(p1 as! Float), forKey: "Passing Rating")
        }
        if let p1 = json["PassingLong"]{
            passingStats.append("Longest Pass")
            passing.updateValue(String(p1 as! Int), forKey: "Longest Pass")
        }
        if let p1 = json["PassingSacks"]{
            passingStats.append("Passing Sacks")
            passing.updateValue(String(p1 as! Int), forKey: "Passing Sacks")
        }
        if let p1 = json["TwoPointConversionPasses"]{
            passingStats.append("2pt Conversion Passes")
            passing.updateValue(String(p1 as! Int), forKey: "2pt Conversion Passes")
        }
        statistics.updateValue(passing, forKey: "Passing")
        
        var rec = Dictionary<String, String>()
        receivingStats = [String]()
        if let r = json["ReceivingYards"]{
            receivingStats.append("Receiving Yards")
            rec.updateValue(String(r as! Int), forKey: "Receiving Yards")
        }
        if let r = json["ReceivingYardsPerReception"]{
            receivingStats.append("Receiving Yards/Reception")
            rec.updateValue(String(r as! Int), forKey: "Receiving Yards/Reception")
        }
        if let r = json["ReceivingTouchdowns"]{
            receivingStats.append("Receiving Touchdowns")
            rec.updateValue(String(r as! Int), forKey: "Receiving Touchdowns")
        }
        if let r = json["ReceivingLong"]{
            receivingStats.append("Longest Reception")
            rec.updateValue(String(r as! Int), forKey: "Longest Reception")
        }
        statistics.updateValue(rec, forKey: "Receiving")
        
        var def = Dictionary<String, String>()
        defensiveStats = [String]()
        if let d = json["Tackles"]{
            defensiveStats.append("Tackles")
            def.updateValue(String(d as! Int), forKey: "Tackles")
        }
        if let d = json["SoloTackles"]{
            defensiveStats.append("Solo Tackles")
            def.updateValue(String(d as! Int), forKey: "Solo Tackles")
        }
        if let d = json["AssistedTackles"]{
            defensiveStats.append("Assisted Tackles")
            def.updateValue(String(d as! Int), forKey: "Assisted Tackles")
        }
        if let d = json["Sacks"]{
            defensiveStats.append("Sacks")
            def.updateValue(String(d as! Int), forKey: "Sacks")
        }
        if let d = json["PassesDefended"]{
            defensiveStats.append("Passes Defended")
            def.updateValue(String(d as! Int), forKey: "Passes Defended")
        }
        if let d = json["BlockedKicks"]{
            defensiveStats.append("Blocked Kicks")
            def.updateValue(String(d as! Int), forKey: "Blocked Kicks")
        }
        if let d = json["OffensiveSnapsPlayed"]{
            defensiveStats.append("Off. Snaps Played")
            def.updateValue(String(d as! Int), forKey: "Off. Snaps Played")
        }
        if let d = json["DefensiveSnapsPlayed"]{
            defensiveStats.append("Def. Snaps Played")
            def.updateValue(String(d as! Int), forKey: "Def. Snaps Played")
        }
        if let d = json["SpecialTeamsSnapsPlayed"]{
            defensiveStats.append("Special Snaps Played")
            def.updateValue(String(d as! Int), forKey: "Tackles")
        }
        if let d = json["OffensiveTeamSnaps"]{
            defensiveStats.append("Off. Team Snaps")
            def.updateValue(String(d as! Int), forKey: "Off. Team Snaps")
        }
        if let d = json["DefensiveTeamSnaps"]{
            defensiveStats.append("Def. Team Snaps")
            def.updateValue(String(d as! Int), forKey: "Def. Team Snaps")
        }
        if let d = json["SpecialTeamSnaps"]{
            defensiveStats.append("Special Team Snaps")
            def.updateValue(String(d as! Int), forKey: "Special Team Snaps")
        }
        statistics.updateValue(def, forKey: "Defense")
        
        var rush = Dictionary<String, String>()
        rushStats = [String]()
        if let r = json["RushingAttempts"]{
            rushStats.append("Rush Attempts")
            rush.updateValue(String(r as! Int), forKey: "Rushing Attempts")
        }
        if let r = json["RushingYardsPerAttempts"]{
            rushStats.append("Rush Yards/Attempt")
            rush.updateValue(String(r as! Float), forKey: "Rushing Yards/Attempt")
        }
        if let r = json["RushingTouchdowns"]{
            rushStats.append("Rush Touchdowns")
            rush.updateValue(String(r as! Int), forKey: "Rushing Touchdowns")
        }
        if let r = json["RushingLong"]{
            rushStats.append("Longest Rush")
            rush.updateValue(String(r as! Int), forKey: "Longest Rush")
        }
        statistics.updateValue(rush, forKey: "Rushing")
        
        var kick = Dictionary<String, String>()
        kickStats = [String]()
        if let k = json["KickReturns"]{
            kickStats.append("Kick Returns")
            kick.updateValue(String(k as! Int), forKey: "Kick Returns")
        }
        if let k = json["KickReturnYards"]{
            kickStats.append("Kick Return Yards")
            kick.updateValue(String(k as! Int), forKey: "Kick Return Yards")
        }
        if let k = json["KickReturnYardsPerAttempt"]{
            kickStats.append("Kick Return Yds/Attempt")
            kick.updateValue(String(k as! Float), forKey: "Kick Return Yds/Attempt")
        }
        if let k = json["KickReturnTouchdowns"]{
            kickStats.append("Kick Return Touchdowns")
            kick.updateValue(String(k as! Int), forKey: "Kick Return Touchdowns")
        }
        if let k = json["KickReturnLong"]{
            kickStats.append("Longest Kick Return")
            kick.updateValue(String(k as! Int), forKey: "Longest Kick Return")
        }
        statistics.updateValue(kick, forKey: "Kicking")
        
        var punt = Dictionary<String, String>()
        puntStats = [String]()
        if let p = json["Punts"]{
            puntStats.append("Punts")
            punt.updateValue(String(p as! Int), forKey: "Punts")
        }
        if let p = json["PuntYards"]{
            puntStats.append("Punt Yds")
            punt.updateValue(String(p as! Int), forKey: "Punt Yds")
        }
        if let p = json["PuntAverage"]{
            puntStats.append("Punt Avg")
            punt.updateValue(String(p as! Int), forKey: "Punt Avg")
        }
        if let p = json["PuntReturns"]{
            puntStats.append("Returns")
            punt.updateValue(String(p as! Int), forKey: "Returns")
        }
        if let p = json["PuntReturnYards"]{
            puntStats.append("Return Yards")
            punt.updateValue(String(p as! Int), forKey: "Return Yards")
        }
        if let p = json["PuntReturnYardsPerAttempt"]{
            puntStats.append("Return Yards/Attempt")
            punt.updateValue(String(p as! Float), forKey: "Return Yards/Attempt")
        }
        if let p = json["PuntReturnTouchdowns"]{
            puntStats.append("Return Touchdowns")
            punt.updateValue(String(p as! Int), forKey: "Return Touchdowns")
        }
        if let p = json["PuntReturnLong"]{
            puntStats.append("Longest Return")
            punt.updateValue(String(p as! Int), forKey: "Longest Return")
        }
        statistics.updateValue(punt, forKey: "Punting")
        
        currentCat = statPickerData[0]
        detail.setUpTableView(statPickerData[0], delegate: self)
    }
    
}