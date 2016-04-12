
import Foundation
import UIKit
import SnapKit

class PlayerDetailView: UIView {
    
    var playerImage: UIImageView!
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
    var currentSheetVisibility: SheetVisibility!
    
    var draftButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init (player: FDPlayer, delegate: HCPlayerMoreDetailController) {
        self.init(frame : CGRectZero)
        addCustomView(delegate)
        setPlayer(player)
        currentSheetVisibility = SheetVisibility.Mid
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
        playerImage.load(player.photoURL)
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
    
    func addCustomView(delegate: HCPlayerMoreDetailController){
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
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
        gameDetailContainer.addSubview(gameDetailLabels)
        
        gameDetail1 = GameStatView()
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail1)
        
        gameDetail2 = GameStatView()
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail2)
        
        gameDetail3 = GameStatView()
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail3)
        
        gameDetail4 = GameStatView()
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail4)
        
        gameDetail5 = GameStatView()
        gameDetailLabels.setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail5)
        
        statCatPicker.dataSource = delegate
        statCatPicker.delegate = delegate
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
    
    func setOverviewData(stat1Label: String, stat1Text: String, stat2Label: String, stat2Text: String, stat3Label: String, stat3Text: String, stat4Label: String, stat4Text: String, stat5Label: String, stat5Text:String, stat6Label: String, stat6Text: String){
        self.stat1Label.text = stat1Label
        self.stat1Text.text = stat1Text
        self.stat2Label.text = stat2Label
        self.stat2Text.text = stat2Text
        self.stat3Label.text = stat3Label
        self.stat3Text.text = stat3Text
        self.stat4Label.text = stat4Label
        self.stat4Text.text = stat4Text
        self.stat5Label.text = stat5Label
        self.stat5Text.text = stat5Text
        self.stat6Label.text = stat6Text
        self.stat6Text.text = stat6Text
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
    
    func setUpTableView(initialCategory: String, delegate: HCPlayerMoreDetailController){
        statCatButton.setTitle(initialCategory, forState: UIControlState.Normal)
        statTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        statTable.delegate = delegate
        statTable.dataSource = delegate
        statTable.setNeedsLayout()
    }
    
    enum SheetVisibility: Int{
        case Gone = 0
        case Mid = 1
        case Full = 2
    }
}