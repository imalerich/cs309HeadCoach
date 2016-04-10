
import Foundation
import UIKit
import SnapKit

class PlayerDetailView: UIView, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    let statPickerData = ["General", "Scoring", "Passing", "Receiving", "Defense", "Rushing", "Kicking", "Punting"]
    var generalStats: [String]!
    var scoringStats: [String]!
    var passingStats: [String]!
    var receivingStats: [String]!
    var defensiveStats: [String]!
    var rushStats: [String]!
    var kickStats: [String]!
    var puntStats: [String]!
    var games: [Game]!
    @IBOutlet var playerImage: UIImageView!
    var nameLabel: UILabel!
    var teamLabel: UILabel!
    var numLabel: UILabel!
    var textContainer: UIView!
    var circle: UIView!
    var headerLabelContainer: UIView!
    var statsLabelsContainer: UIView!
    var personalDetailsContainer: UIView!
    var personalDetailsLabel: UILabel!
    var gameTable: UITableView!
    var statusLabel: UILabel!
    var statusText: UILabel!
    var statusTextContainer: UIView!
    var detailContainer: UIView!
    let statCatPicker = UIPickerView()
    let statCatLabel = UILabel()
    var statCatButton: UIButton!
    var statOverviewContainer: UIView!
    var stat1Container: UIView!
    var stat1Label: UILabel!
    var stat1Text: UILabel!
    var stat2Container: UIView!
    var stat2Label: UILabel!
    var stat2Text: UILabel!
    var stat3Container: UIView!
    var stat3Label: UILabel!
    var stat3Text: UILabel!
    var stat4Container: UIView!
    var stat4Label: UILabel!
    var stat4Text: UILabel!
    var stat5Container: UIView!
    var stat5Label: UILabel!
    var stat5Text: UILabel!
    var stat6Container: UIView!
    var stat6Label: UILabel!
    var stat6Text: UILabel!
    var statTable: UITableView!
    var statTableContainer: UIView!
    var moreStatsButton: UIButton!
    var moreGamesButton: UIButton!
    var bottom: UIView!
    var bottomDiv: UIView!
    var gameDetailContainer: UIView!
    var gameDetailLabels: GameStatView!
    var gameDetail1: GameStatView!
    var gameDetail2: GameStatView!
    var gameDetail3: GameStatView!
    var gameDetail4: GameStatView!
    var gameDetail5: GameStatView!
    var currentCat: String!
    var currentSheetVisibility: SheetVisibility!
    
    var statistics: Dictionary<String, Dictionary<String, String>>!
    
    var draftButton: UIButton!

    override init (frame : CGRect) {
        super.init(frame : frame)
        statistics = Dictionary<String, Dictionary<String, String>>()
        currentSheetVisibility = SheetVisibility.Mid
    }
    
    convenience init () {
        self.init(frame:CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    func setPlayer(player: FDPlayer){
        nameLabel.text = player.name
        if(!player.fantasyPosition.isEmpty){
            teamLabel.text = player.fantasyPosition + " for " + player.team
        }else{
            teamLabel.text = player.team
        }
        numLabel.text = "#" + String(player.number)
        statusText.text = player.status
        statusTextContainer.backgroundColor = getStatusBackground(player.status)
        stat2Text.text = String(arc4random_uniform(100) + 1)
        stat1Text.text = String(arc4random_uniform(12) + 1)
        stat4Label.text = String(arc4random_uniform(40)) + " pts."
        stat4Text.text = String(arc4random_uniform(40)) + " pts."
        playerImage.load(player.photoURL)
        setNeedsLayout()
        
    }
    
    func setStatisticalData(json: Dictionary<String, AnyObject>) {
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
        
        setUpTableView()
        print("omg parsed")
    }
    
    func setStats(id: Int, json: NSArray) -> Void{
        var passYds: Int = 0
        var rushYds: Int = 0
        var tds: Int = 0
        for item in json{
            let data = item as! NSDictionary
            passYds = data["PassingYards"] as! Int
            rushYds = data["RushingYards"] as! Int
            tds = data["Touchdowns"] as! Int
            print("got data")
        }
        setNeedsLayout()
    }
    
    func getStatusBackground(status: String) -> UIColor{
        switch(status){
            case "Healthy": return UIColor.init(red: 0, green: 0.8, blue: 0, alpha: 0.9)
            case "Injured": return UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.9)
            case "Free Agent": return UIColor.init(red: 0, green: 0, blue: 0.8, alpha: 0.9)
            default: return UIColor.blackColor()
        }
    }
    
    func addCustomView(){
        backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        detailContainer = UIView()
        detailContainer.backgroundColor = UIColor.whiteColor()
        detailContainer.layer.masksToBounds = true
        detailContainer.layer.cornerRadius = 4
        detailContainer.layer.borderWidth = 5
        detailContainer.layer.borderColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1).CGColor
        addSubview(detailContainer)
        
        personalDetailsContainer = UIView()
        personalDetailsContainer.backgroundColor = UIColor.init(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        detailContainer.addSubview(personalDetailsContainer)
        
        circle = UIView()
        addSubview(circle)
        
        headerLabelContainer = UIView()
        headerLabelContainer.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        headerLabelContainer.layer.masksToBounds = true
        headerLabelContainer.layer.cornerRadius = 4
        addSubview(headerLabelContainer)
        
        statTableContainer = UIView()
        statTableContainer.backgroundColor = UIColor.whiteColor()
        statTableContainer.hidden = true
        detailContainer.addSubview(statTableContainer)
        
        statTable = UITableView()
        statTable.backgroundColor = UIColor.whiteColor()
        statTableContainer.addSubview(statTable)
        
        statCatLabel.text = "Category: "
        statCatLabel.textAlignment = .Center
        statCatLabel.textColor = UIColor.blackColor()
        statCatLabel.font = statCatLabel.font.fontWithSize(12)
        statCatLabel.sizeToFit()
        statCatLabel.hidden = true
        personalDetailsContainer.addSubview(statCatLabel)
        
        statCatButton = UIButton.init(type: UIButtonType.System)
        statCatButton.setTitle(statPickerData[0], forState: UIControlState.Normal)
        statCatButton.titleLabel!.font = statCatButton.titleLabel!.font.fontWithSize(12)
        statCatButton.sizeToFit()
        statCatButton.hidden = true
        personalDetailsContainer.addSubview(statCatButton)
        
        statOverviewContainer = UIView()
        detailContainer.addSubview(statOverviewContainer)
        
        stat1Container = UIView()
        statOverviewContainer.addSubview(stat1Container)
        
        stat1Label = UILabel()
        stat1Label.textAlignment = .Center
        stat1Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat1Label.font = stat1Label.font.fontWithSize(15)
        stat1Label.sizeToFit()
        stat1Label.text = "Bye Week"
        stat1Container.addSubview(stat1Label)
        
        stat1Text = UILabel()
        stat1Text.textAlignment = .Center
        stat1Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat1Text.font = stat1Text.font.fontWithSize(14)
        stat1Text.sizeToFit()
        stat1Text.text = "13"
        stat1Container.addSubview(stat1Text)
        
        stat2Container = UIView()
        statOverviewContainer.addSubview(stat2Container)
        
        stat2Label = UILabel()
        stat2Label.textAlignment = .Center
        stat2Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat2Label.font = stat2Label.font.fontWithSize(15)
        stat2Label.sizeToFit()
        stat2Label.text = "Rank"
        stat2Container.addSubview(stat2Label)
        
        stat2Text = UILabel()
        stat2Text.textAlignment = .Center
        stat2Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat2Text.font = stat2Text.font.fontWithSize(14)
        stat2Text.sizeToFit()
        stat2Text.text = "9"
        stat2Container.addSubview(stat2Text)
        
        stat3Container = UIView()
        statOverviewContainer.addSubview(stat3Container)
        
        stat3Label = UILabel()
        stat3Label.textAlignment = .Center
        stat3Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat3Label.font = stat3Label.font.fontWithSize(15)
        stat3Label.sizeToFit()
        let random = arc4random_uniform(12)
        stat3Label.text = "Week " + String(random)
        stat3Container.addSubview(stat3Label)
        
        stat3Text = UILabel()
        stat3Text.textAlignment = .Center
        stat3Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat3Text.font = stat3Text.font.fontWithSize(14)
        stat3Text.sizeToFit()
        stat3Text.text = "17 pts"
        stat3Container.addSubview(stat3Text)
        
        stat4Container = UIView()
        statOverviewContainer.addSubview(stat4Container)
        
        stat4Label = UILabel()
        stat4Label.textAlignment = .Center
        stat4Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat4Label.font = stat4Label.font.fontWithSize(15)
        stat4Label.sizeToFit()
        stat4Label.text = "Week " + String(random+1)
        stat4Container.addSubview(stat4Label)
        
        stat4Text = UILabel()
        stat4Text.textAlignment = .Center
        stat4Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat4Text.font = stat4Text.font.fontWithSize(14)
        stat4Text.sizeToFit()
        stat4Text.text = "24 pts"
        stat4Container.addSubview(stat4Text)
        
        stat5Container = UIView()
        statOverviewContainer.addSubview(stat5Container)
        
        stat5Label = UILabel()
        stat5Label.textAlignment = .Center
        stat5Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat5Label.font = stat5Label.font.fontWithSize(15)
        stat5Label.sizeToFit()
        stat5Label.text = "Stat 5"
        stat5Container.addSubview(stat5Label)
        
        stat5Text = UILabel()
        stat5Text.textAlignment = .Center
        stat5Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat5Text.font = stat5Text.font.fontWithSize(14)
        stat5Text.sizeToFit()
        stat5Text.text = "24 yds"
        stat5Container.addSubview(stat5Text)
        
        stat6Container = UIView()
        statOverviewContainer.addSubview(stat6Container)
        
        stat6Label = UILabel()
        stat6Label.textAlignment = .Center
        stat6Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat6Label.font = stat6Label.font.fontWithSize(15)
        stat6Label.sizeToFit()
        stat6Label.text = "Stat 6"
        stat6Container.addSubview(stat6Label)
        
        stat6Text = UILabel()
        stat6Text.textAlignment = .Center
        stat6Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat6Text.font = stat6Text.font.fontWithSize(14)
        stat6Text.sizeToFit()
        stat6Text.text = "235"
        stat6Container.addSubview(stat6Text)

        nameLabel = UILabel()
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.numberOfLines = 1
        nameLabel.font = nameLabel.font.fontWithSize(18)
        nameLabel.sizeToFit()
        headerLabelContainer.addSubview(nameLabel)
        
        numLabel = UILabel()
        numLabel.textAlignment = .Left
        numLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        numLabel.numberOfLines = 1
        numLabel.font = numLabel.font.fontWithSize(14)
        numLabel.sizeToFit()
        headerLabelContainer.addSubview(numLabel)
        
        teamLabel = UILabel()
        teamLabel.textAlignment = .Left
        teamLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        teamLabel.numberOfLines = 1
        teamLabel.font = teamLabel.font.fontWithSize(14)
        teamLabel.sizeToFit()
        headerLabelContainer.addSubview(teamLabel)
        
        personalDetailsLabel = UILabel()
        personalDetailsLabel.textAlignment = .Center
        personalDetailsLabel.text = "Overview"
        personalDetailsLabel.textColor = UIColor.blackColor()
        personalDetailsLabel.font = personalDetailsLabel.font.fontWithSize(14)
        personalDetailsLabel.backgroundColor = personalDetailsContainer.backgroundColor
        personalDetailsContainer.addSubview(personalDetailsLabel)
        
        statusLabel = UILabel()
        statusLabel.font = statusLabel.font.fontWithSize(12)
        statusLabel.text = "Status"
        headerLabelContainer.addSubview(statusLabel)
        
        statusTextContainer = UIView()
        statusTextContainer.layer.masksToBounds = true
        statusTextContainer.layer.cornerRadius = 3
        headerLabelContainer.addSubview(statusTextContainer)
        
        statusText = UILabel()
        statusText.font = statusText.font.fontWithSize(12)
        statusText.textColor = UIColor.whiteColor()
        headerLabelContainer.addSubview(statusText)
        
        draftButton = UIButton.init(type: UIButtonType.System)
        draftButton.setTitle("Draft", forState: UIControlState.Normal)
        draftButton.titleLabel!.font = draftButton.titleLabel!.font.fontWithSize(14)
        draftButton.titleLabel!.textAlignment = .Center
        draftButton.sizeToFit()
        draftButton.setTitleColor(UIColor.init(red: 0, green: 0, blue: 0.8, alpha: 1), forState: UIControlState.Normal)
        headerLabelContainer.addSubview(draftButton)
        
        playerImage = UIImageView()
        playerImage.layer.shadowOffset = CGSize(width: 0, height: -3)
        playerImage.layer.shadowOpacity = 0.5
        playerImage.layer.shadowRadius = 4
        addSubview(playerImage)
        
        bottom = UIView()
        bottom.backgroundColor = UIColor.whiteColor()
        detailContainer.addSubview(bottom)
        
        bottomDiv = UIView()
        bottomDiv.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        bottom.addSubview(bottomDiv)
        
        moreStatsButton = UIButton.init(type: UIButtonType.System)
        moreStatsButton.setTitle("More stats", forState: UIControlState.Normal)
        moreStatsButton.titleLabel!.font = moreStatsButton.titleLabel!.font.fontWithSize(12)
        moreStatsButton.sizeToFit()
        detailContainer.addSubview(moreStatsButton)
        
        moreGamesButton = UIButton.init(type: UIButtonType.System)
        moreGamesButton.setTitle("More games", forState: UIControlState.Normal)
        moreGamesButton.titleLabel!.font = moreGamesButton.titleLabel!.font.fontWithSize(12)
        moreGamesButton.sizeToFit()
        bottom.addSubview(moreGamesButton)
        
        gameDetailContainer = UIView()
        gameDetailContainer.backgroundColor = UIColor.whiteColor()
        bottom.addSubview(gameDetailContainer)
        
        gameDetailLabels = GameStatView()
        gameDetailLabels.week.text = "Week"
        gameDetailLabels.opp.text = "Opp"
        gameDetailLabels.points.text = "Pts"
        gameDetailLabels.started.text = "Started"
        gameDetailContainer.addSubview(gameDetailLabels)
        
        gameDetail1 = GameStatView()
        gameDetailContainer.addSubview(gameDetail1)
        
        gameDetail2 = GameStatView()
        gameDetailContainer.addSubview(gameDetail2)
        
        gameDetail3 = GameStatView()
        gameDetailContainer.addSubview(gameDetail3)
        
        gameDetail4 = GameStatView()
        gameDetailContainer.addSubview(gameDetail4)
        
        gameDetail5 = GameStatView()
        gameDetailContainer.addSubview(gameDetail5)
        
        statCatPicker.dataSource = self
        statCatPicker.delegate = self
        statCatPicker.hidden = true
        addSubview(statCatPicker)
//        table = UITableView()
//        addSubview(table)
        
        moreStatsButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        moreGamesButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        statCatButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        
        setConstraints()
        setNeedsLayout()
    }
    
    func setConstraints(){
        playerImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(10)
            make.left.equalTo(self.snp_left).inset(10)
            make.height.equalTo(self).multipliedBy(0.17)
            make.width.equalTo(playerImage.snp_height).multipliedBy(0.72)
        }
        circle.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_left).offset(-5)
            make.right.equalTo(playerImage.snp_right).offset(5)
            make.top.equalTo(playerImage.snp_top).offset(-5)
            make.bottom.equalTo(playerImage.snp_bottom).offset(5)
        }
        headerLabelContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(playerImage.snp_top).inset(5)
            make.bottom.equalTo(playerImage.snp_bottom).inset(5)
            make.left.equalTo(playerImage.snp_centerX)
            make.right.equalTo(self.snp_right).inset(5)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_right).offset(5)
            make.top.equalTo(headerLabelContainer).offset(5)
        }
        numLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_right).offset(5)
            make.bottom.lessThanOrEqualTo(statusTextContainer.snp_top)
            make.top.equalTo(nameLabel.snp_bottom)
        }
        teamLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(numLabel.snp_right).offset(5)
            make.top.equalTo(numLabel)
            make.bottom.equalTo(numLabel)
        }
        statusLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headerLabelContainer).inset(8)
        }
        statusText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(statusLabel.snp_right).offset(8)
            make.bottom.equalTo(headerLabelContainer).inset(8)
        }
        statusTextContainer.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(statusText.snp_right).offset(2)
            make.left.equalTo(statusText.snp_left).offset(-2)
            make.top.equalTo(statusText.snp_top).offset(-2)
            make.bottom.equalTo(statusText.snp_bottom).offset(2)
        }
        draftButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(headerLabelContainer.snp_centerY)
            make.right.equalTo(headerLabelContainer).inset(5)
        }
        detailContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerLabelContainer.snp_bottom).inset(5)
            make.left.equalTo(self).inset(15)
            make.right.equalTo(self).inset(15)
            make.bottom.equalTo(self.snp_bottom).inset(15)
        }
        personalDetailsContainer.snp_makeConstraints { (make) in
            make.top.equalTo(detailContainer)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.height.equalTo(detailContainer).dividedBy(10)
        }
        personalDetailsLabel.snp_makeConstraints { (make) in
            make.center.equalTo(personalDetailsContainer)
        }
        statOverviewContainer.snp_makeConstraints { (make) in
            make.width.equalTo(detailContainer)
            make.top.equalTo(detailContainer)
            make.height.equalTo(detailContainer).dividedBy(5)
        }
        stat1Container.snp_makeConstraints { (make) in
            make.height.equalTo(detailContainer).multipliedBy(0.15)
            make.width.equalTo(detailContainer).dividedBy(3)
            make.left.equalTo(detailContainer)
            make.top.equalTo(personalDetailsContainer.snp_bottom)
        }
        stat1Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat1Container.snp_centerX)
            make.bottom.equalTo(stat1Container.snp_centerY)
        }
        stat1Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat1Container.snp_centerX)
            make.top.equalTo(stat1Container.snp_centerY)
        }
        stat2Container.snp_makeConstraints { (make) in
            make.height.equalTo(stat1Container)
            make.width.equalTo(stat1Container)
            make.top.equalTo(stat1Container)
            make.left.equalTo(stat1Container.snp_right)
        }
        stat2Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat2Container.snp_centerX)
            make.bottom.equalTo(stat2Container.snp_centerY)
        }
        stat2Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat2Container.snp_centerX)
            make.top.equalTo(stat2Container.snp_centerY)
        }
        stat3Container.snp_makeConstraints { (make) in
            make.height.equalTo(stat1Container)
            make.width.equalTo(stat1Container)
            make.top.equalTo(stat1Container)
            make.left.equalTo(stat2Container.snp_right)
        }
        stat3Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat3Container.snp_centerX)
            make.bottom.equalTo(stat3Container.snp_centerY)
        }
        stat3Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat3Container.snp_centerX)
            make.top.equalTo(stat3Container.snp_centerY)
        }
        stat4Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat1Container)
            make.right.equalTo(stat1Container)
            make.height.equalTo(stat1Container)
            make.top.equalTo(stat1Container.snp_bottom)
        }
        stat4Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat4Container.snp_centerX)
            make.bottom.equalTo(stat4Container.snp_centerY)
        }
        stat4Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat4Container.snp_centerX)
            make.top.equalTo(stat4Container.snp_centerY)
        }
        stat5Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat2Container)
            make.right.equalTo(stat2Container)
            make.height.equalTo(stat2Container)
            make.top.equalTo(stat2Container.snp_bottom)
        }
        stat5Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat5Container.snp_centerX)
            make.bottom.equalTo(stat5Container.snp_centerY)
        }
        stat5Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat5Container.snp_centerX)
            make.top.equalTo(stat5Container.snp_centerY)
        }
        stat6Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat3Container)
            make.right.equalTo(stat3Container)
            make.height.equalTo(stat3Container)
            make.top.equalTo(stat3Container.snp_bottom)
        }
        stat6Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat6Container.snp_centerX)
            make.bottom.equalTo(stat6Container.snp_centerY)
        }
        stat6Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat6Container.snp_centerX)
            make.top.equalTo(stat6Container.snp_centerY)
        }
        statCatButton.snp_makeConstraints { (make) in
            make.center.equalTo(personalDetailsContainer.snp_center)
        }
        statCatLabel.snp_makeConstraints { (make) in
            make.right.equalTo(statCatButton.snp_left)
            make.centerY.equalTo(personalDetailsContainer.snp_centerY)
        }
        statTableContainer.snp_makeConstraints { (make) in
            make.top.equalTo(personalDetailsContainer.snp_bottom)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(detailContainer)
        }
        statTable.snp_makeConstraints { (make) in
            make.top.equalTo(personalDetailsContainer.snp_bottom)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(bottom.snp_top)
        }
        bottom.snp_makeConstraints { (make) in
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(detailContainer)
            make.top.equalTo(stat4Container.snp_bottom).offset(10)
        }
        bottomDiv.snp_makeConstraints { (make) in
            make.left.equalTo(bottom)
            make.right.equalTo(bottom)
            make.top.equalTo(bottom)
            make.height.equalTo(5)
        }
        moreStatsButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(bottom.snp_top)
            make.right.equalTo(bottom.snp_right).inset(10)
        }
        moreGamesButton.snp_makeConstraints { (make) in
            make.top.equalTo(bottom.snp_top).offset(5)
            make.right.equalTo(moreStatsButton)
        }
        gameDetailContainer.snp_makeConstraints { (make) in
            make.left.equalTo(bottom)
            make.right.equalTo(bottom)
            make.bottom.equalTo(bottom)
            make.top.equalTo(bottom).inset(moreGamesButton.bounds.height)
        }
        gameDetailLabels.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailContainer).inset(5)
            make.right.equalTo(gameDetailContainer).inset(5)
            make.top.equalTo(gameDetailContainer)
            make.height.equalTo(gameDetailContainer).dividedBy(6)
        }
        gameDetail1.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetailLabels.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }
        gameDetail2.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail1.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }
        gameDetail3.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail2.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }
        gameDetail4.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail3.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }
        gameDetail5.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail4.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }
        statCatPicker.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    func updateSheet(newVisibility: SheetVisibility){
        switch(newVisibility){
        case SheetVisibility.Gone:
            if(currentSheetVisibility == SheetVisibility.Mid || currentSheetVisibility == SheetVisibility.Full){
                currentSheetVisibility = SheetVisibility.Gone
            }
            break
        case SheetVisibility.Mid:
            if(currentSheetVisibility == SheetVisibility.Full || currentSheetVisibility == SheetVisibility.Gone){
                currentSheetVisibility = SheetVisibility.Mid
            }
            break
        case SheetVisibility.Full:
            if(currentSheetVisibility == SheetVisibility.Mid || currentSheetVisibility == SheetVisibility.Gone){
                currentSheetVisibility = SheetVisibility.Full
            }
            break
        }
        updateSheetSize(newVisibility)
    }
    
    func updateSheetSize(newVisibility: SheetVisibility){
        switch(newVisibility){
        case SheetVisibility.Gone:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(detailContainer.snp_bottom)
            })
            personalDetailsLabel.snp_remakeConstraints(closure: { (make) in
                make.right.equalTo(personalDetailsContainer).inset(5)
                make.bottom.equalTo(personalDetailsContainer)
            })
            self.statTableContainer.hidden = false
            self.statCatLabel.hidden = false
            self.statCatButton.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 1.0
                self.moreGamesButton.alpha = 0.0
                self.statCatLabel.alpha = 1.0
                self.statCatButton.alpha = 1.0
                self.statOverviewContainer.alpha = 0.0
                }, completion: { b in
                    if(b){
                        self.moreGamesButton.hidden = true
                        self.statOverviewContainer.hidden = true
                    }
            })
            personalDetailsLabel.text = "Statistics"
            personalDetailsLabel.hidden = false
            moreStatsButton.setTitle("Less", forState: UIControlState.Normal)
            break
        case SheetVisibility.Mid:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(stat4Container.snp_bottom).offset(10)
            })
            personalDetailsLabel.snp_remakeConstraints(closure: { (make) in
                make.center.equalTo(personalDetailsContainer)
            })
            self.statOverviewContainer.hidden = false
            self.moreStatsButton.hidden = false
            self.moreGamesButton.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 0.0
                self.moreGamesButton.alpha = 1.0
                self.moreStatsButton.alpha = 1.0
                self.statCatButton.alpha = 0.0
                self.statCatLabel.alpha = 0.0
                self.statOverviewContainer.alpha = 1.0
                self.personalDetailsLabel.text = "Overview"
                }, completion: { b in
                    if(b){
                        self.statTableContainer.hidden = true
                    }
            })
            moreGamesButton.setTitle("More games", forState: UIControlState.Normal)
            moreStatsButton.setTitle("More stats", forState: UIControlState.Normal)
            break
        case SheetVisibility.Full:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(personalDetailsContainer.snp_bottom)
            })
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 0.0
                self.moreStatsButton.alpha = 0.0
                }, completion: { b in
                    if(b){
                        self.statTableContainer.hidden = true
                        self.moreStatsButton.hidden = true
                    }
            })
            personalDetailsLabel.text = "Performance"
            moreGamesButton.setTitle("Less", forState: UIControlState.Normal)
            break
        }
        UIView.animateWithDuration(0.5){
            self.detailContainer.layoutIfNeeded()
        }
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
    
    func setUpTableView(){
        currentCat = statPickerData[0]
        statCatButton.setTitle(currentCat, forState: UIControlState.Normal)
        statTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        statTable.delegate = self
        statTable.dataSource = self
        statTable.setNeedsLayout()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView === statTable){
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
    
    override func layoutSubviews(){
        super.layoutSubviews()
        circle.layer.masksToBounds = true
        circle.layer.borderWidth = 0
        circle.layer.cornerRadius = circle.bounds.width / 2;
        circle.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        playerImage.layer.masksToBounds=true
        playerImage.layer.borderWidth = 1
        playerImage.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1 ).CGColor
        playerImage.layer.cornerRadius = playerImage.bounds.width / 2
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === moreGamesButton {
            if(currentSheetVisibility == SheetVisibility.Full){
                updateSheet(SheetVisibility.Mid)
            }else if(currentSheetVisibility == SheetVisibility.Mid){
                updateSheet(SheetVisibility.Full)
            }
        }else if sender === moreStatsButton{
            if(currentSheetVisibility == SheetVisibility.Mid){
                updateSheet(SheetVisibility.Gone)
            }else if(currentSheetVisibility == SheetVisibility.Gone){
                updateSheet(SheetVisibility.Mid)
            }
        }else if sender === statCatButton{
            showPicker()
        }
    }
    
    func showPicker(){
        if(statCatPicker.hidden == true){
            statCatPicker.hidden = false
            UIView.animateWithDuration(0.5, animations: { 
                self.statCatPicker.alpha = 1.0
            })
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statPickerData.capacity
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCat = statPickerData[row]
        statCatButton.setTitle(currentCat, forState: UIControlState.Normal)
        statTable.reloadData()
        UIView.animateWithDuration(0.5, animations: {
            self.statCatPicker.alpha = 0.0
            }, completion: { b in
                if(b){
                    self.statCatPicker.hidden = true
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
    
    enum SheetVisibility: Int{
        case Gone = 0
        case Mid = 1
        case Full = 2
    }
}