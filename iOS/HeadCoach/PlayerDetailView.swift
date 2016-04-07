
import Foundation
import UIKit
import SnapKit

class PlayerDetailView: UIView {
    
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
    var ageLabel: UILabel!
    var ageText: UILabel!
    var heightLabel: UILabel!
    var weightLabel: UILabel!
    var heightText: UILabel!
    var weightText:UILabel!
    var table: UITableView!
    var statusLabel: UILabel!
    var statusText: UILabel!
    var statusTextContainer: UIView!
    var detailContainer: UIView!
    var stat1Label: UILabel!
    var stat1Text: UILabel!
    var stat2Label: UILabel!
    var stat2Text: UILabel!
    var stat3Label: UILabel!
    var stat3Text: UILabel!
    var stat4Label: UILabel!
    var stat4Text: UILabel!
    var stat5Label: UILabel!
    var stat5Text: UILabel!
    var stat6Label: UILabel!
    var stat6Text: UILabel!
    
    var draftButton: UIButton!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        addCustomView()
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
        weightText.text = String(player.weight) + " lbs."
        heightText.text = player.height
        statusText.text = player.status
        statusTextContainer.backgroundColor = getStatusBackground(player.status)
        stat2Text.text = String(arc4random_uniform(100) + 1)
        stat1Text.text = String(arc4random_uniform(12) + 1)
        stat4Label.text = String(arc4random_uniform(40)) + " pts."
        stat4Text.text = String(arc4random_uniform(40)) + " pts."
        playerImage.load(player.photoURL)
        setNeedsLayout()
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
        backgroundColor = UIColor.whiteColor()
        
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
        
//        personalDetailsLabel = UILabel()
//        personalDetailsLabel.textAlignment = .Center
//        personalDetailsLabel.textColor = UIColor.blackColor()
//        personalDetailsLabel.text = "Personal Details"
//        personalDetailsLabel.font = personalDetailsLabel.font.fontWithSize(14)
//        personalDetailsLabel.sizeToFit()
//        personalDetailsContainer.addSubview(personalDetailsLabel)
        
        circle = UIView()
        addSubview(circle)
        
        headerLabelContainer = UIView()
        headerLabelContainer.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        headerLabelContainer.layer.masksToBounds = true
        headerLabelContainer.layer.cornerRadius = 4
        addSubview(headerLabelContainer)
        
        stat1Label = UILabel()
        stat1Label.textAlignment = .Center
        stat1Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat1Label.font = stat1Label.font.fontWithSize(14)
        stat1Label.sizeToFit()
        stat1Label.text = "Bye Week"
        detailContainer.addSubview(stat1Label)
        
        stat1Text = UILabel()
        stat1Text.textAlignment = .Center
        stat1Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat1Text.font = stat1Text.font.fontWithSize(14)
        stat1Text.sizeToFit()
        stat1Text.text = "13"
        detailContainer.addSubview(stat1Text)
        
        stat2Label = UILabel()
        stat2Label.textAlignment = .Center
        stat2Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat2Label.font = stat2Label.font.fontWithSize(14)
        stat2Label.sizeToFit()
        stat2Label.text = "Rank"
        detailContainer.addSubview(stat2Label)
        
        stat2Text = UILabel()
        stat2Text.textAlignment = .Center
        stat2Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat2Text.font = stat2Text.font.fontWithSize(14)
        stat2Text.sizeToFit()
        stat2Text.text = "9"
        detailContainer.addSubview(stat2Text)
        
        stat3Label = UILabel()
        stat3Label.textAlignment = .Center
        stat3Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat3Label.font = stat3Label.font.fontWithSize(14)
        stat3Label.sizeToFit()
        let random = arc4random_uniform(12)
        stat3Label.text = "Week " + String(random)
        detailContainer.addSubview(stat3Label)
        
        stat3Text = UILabel()
        stat3Text.textAlignment = .Center
        stat3Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat3Text.font = stat3Text.font.fontWithSize(14)
        stat3Text.sizeToFit()
        stat3Text.text = "17 pts"
        detailContainer.addSubview(stat3Text)
        
        stat4Label = UILabel()
        stat4Label.textAlignment = .Center
        stat4Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat4Label.font = stat4Label.font.fontWithSize(14)
        stat4Label.sizeToFit()
        stat4Label.text = "Week " + String(random+1)
        detailContainer.addSubview(stat4Label)
        
        stat4Text = UILabel()
        stat4Text.textAlignment = .Center
        stat4Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat4Text.font = stat4Text.font.fontWithSize(14)
        stat4Text.sizeToFit()
        stat4Text.text = "24 pts"
        detailContainer.addSubview(stat4Text)
        
        stat5Label = UILabel()
        stat5Label.textAlignment = .Center
        stat5Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat5Label.font = stat5Label.font.fontWithSize(14)
        stat5Label.sizeToFit()
        stat5Label.text = "Stat 5"
        detailContainer.addSubview(stat5Label)
        
        stat5Text = UILabel()
        stat5Text.textAlignment = .Center
        stat5Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat5Text.font = stat5Text.font.fontWithSize(14)
        stat5Text.sizeToFit()
        stat5Text.text = "24 yds"
        detailContainer.addSubview(stat5Text)
        
        stat6Label = UILabel()
        stat6Label.textAlignment = .Center
        stat6Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat6Label.font = stat6Label.font.fontWithSize(14)
        stat6Label.sizeToFit()
        stat6Label.text = "Stat 6"
        detailContainer.addSubview(stat6Label)
        
        stat6Text = UILabel()
        stat6Text.textAlignment = .Center
        stat6Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat6Text.font = stat6Text.font.fontWithSize(14)
        stat6Text.sizeToFit()
        stat6Text.text = "235"
        detailContainer.addSubview(stat6Text)

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
        numLabel.font = numLabel.font.fontWithSize(16)
        numLabel.sizeToFit()
        headerLabelContainer.addSubview(numLabel)
        
        teamLabel = UILabel()
        teamLabel.textAlignment = .Left
        teamLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        teamLabel.numberOfLines = 1
        teamLabel.font = teamLabel.font.fontWithSize(16)
        teamLabel.sizeToFit()
        headerLabelContainer.addSubview(teamLabel)
        
        ageLabel = UILabel()
        ageLabel.textAlignment = .Right
        ageLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        ageLabel.numberOfLines = 1
        ageLabel.text = "Age"
        ageLabel.font = ageLabel.font.fontWithSize(12)
        ageLabel.sizeToFit()
        personalDetailsContainer.addSubview(ageLabel)
        
        ageText = UILabel()
        ageText.textAlignment = .Left
        ageText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        ageText.numberOfLines = 1
        ageText.font = ageText.font.fontWithSize(12)
        ageText.text = "28"
        ageText.sizeToFit()
        personalDetailsContainer.addSubview(ageText)
        
        heightLabel = UILabel()
        heightLabel.textAlignment = .Right
        heightLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        heightLabel.text = "Height"
        heightLabel.sizeToFit()
        heightLabel.numberOfLines = 1
        heightLabel.font = heightLabel.font.fontWithSize(12)
        personalDetailsContainer.addSubview(heightLabel)
        
        weightLabel = UILabel()
        weightLabel.textAlignment = .Right
        weightLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        weightLabel.text = "Weight"
        weightLabel.sizeToFit()
        weightLabel.numberOfLines = 1
        weightLabel.font = weightLabel.font.fontWithSize(heightLabel.font.pointSize)
        personalDetailsContainer.addSubview(weightLabel)
        
        weightText = UILabel()
        weightText.textAlignment = .Left
        weightText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        weightText.numberOfLines = 1
        weightText.sizeToFit()
        weightText.font = weightText.font.fontWithSize(heightLabel.font.pointSize)
        personalDetailsContainer.addSubview(weightText)
        
        heightText = UILabel()
        heightText.textAlignment = .Left
        heightText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        heightText.numberOfLines = 1
        heightText.sizeToFit()
        heightText.font = heightText.font.fontWithSize(heightLabel.font.pointSize)
        personalDetailsContainer.addSubview(heightText)
        
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
        draftButton.setTitle("Trade", forState: UIControlState.Normal)
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
        
        table = UITableView()
        addSubview(table)
        
        setConstraints()
        setNeedsLayout()
    }
    
    func setConstraints(){
        playerImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(15)
            make.left.equalTo(self.snp_left).inset(15)
            make.height.equalTo(self).multipliedBy(0.15)
            make.width.equalTo(playerImage.snp_height).multipliedBy(0.72)
        }
        circle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(10)
            make.left.equalTo(self.snp_left).inset(10)
            make.right.equalTo(playerImage.snp_right).offset(5)
            make.bottom.equalTo(playerImage.snp_bottom).offset(5)
        }
        headerLabelContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(playerImage.snp_top).inset(5)
            make.bottom.equalTo(playerImage.snp_bottom).inset(5)
            make.left.equalTo(playerImage.snp_centerX)
            make.right.equalTo(self.snp_right).inset(10)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_right).offset(5)
            make.top.equalTo(headerLabelContainer).offset(5)
        }
        numLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_right).offset(5)
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
            make.bottom.equalTo(headerLabelContainer).inset(5)
            make.right.equalTo(headerLabelContainer).inset(5)
        }
        detailContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerLabelContainer.snp_bottom).inset(5)
            make.left.equalTo(self).inset(20)
            make.right.equalTo(self).inset(20)
            make.bottom.equalTo(self.snp_bottom).inset(20)
        }
        personalDetailsContainer.snp_makeConstraints { (make) in
            make.top.equalTo(detailContainer)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.height.equalTo(detailContainer).dividedBy(10)
        }
//        personalDetailsLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(personalDetailsContainer).offset(10)
//            make.centerX.equalTo(personalDetailsContainer.snp_centerX)
//        }
        ageLabel.snp_makeConstraints { (make) in
            make.left.equalTo(personalDetailsContainer)
            make.width.equalTo(personalDetailsContainer).dividedBy(6)
            make.centerY.equalTo(personalDetailsContainer.snp_centerY)
        }
        ageText.snp_makeConstraints { (make) in
            make.top.equalTo(ageLabel)
            make.left.equalTo(ageLabel.snp_right).offset(2)
            make.width.equalTo(ageLabel)
        }
        weightLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(ageLabel)
            make.left.equalTo(ageText.snp_right)
            make.width.equalTo(ageLabel)
        }
        weightText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(weightLabel)
            make.left.equalTo(weightLabel.snp_right).offset(2)
            make.width.equalTo(ageLabel)
        }
        heightLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(ageLabel)
            make.left.equalTo(weightText.snp_right)
            make.width.equalTo(ageLabel)
        }
        heightText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(ageLabel)
            make.left.equalTo(heightLabel.snp_right).offset(2)
            make.width.equalTo(ageLabel)
        }
        let halfDetail = detailContainer.bounds.height
        stat1Label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(detailContainer)
            make.width.equalTo(detailContainer).dividedBy(3)
            make.top.equalTo(personalDetailsContainer.snp_bottom).offset(10)
        }
        stat1Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat1Label)
            make.right.equalTo(stat1Label)
            make.top.equalTo(stat1Label.snp_bottom)
        }
        stat3Label.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(detailContainer)
            make.width.equalTo(detailContainer).dividedBy(3)
            make.top.equalTo(stat1Label)
        }
        stat3Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat3Label)
            make.right.equalTo(stat3Label)
            make.top.equalTo(stat3Label.snp_bottom)
        }
        stat2Label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat1Label.snp_right)
            make.right.equalTo(stat3Label.snp_left)
            make.top.equalTo(stat1Label)
        }
        stat2Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat2Label)
            make.right.equalTo(stat2Label)
            make.top.equalTo(stat2Label.snp_bottom)
        }
        stat4Label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat1Label)
            make.right.equalTo(stat1Label)
            make.top.equalTo(stat1Text.snp_bottom).offset(10)
        }
        stat4Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat4Label)
            make.right.equalTo(stat4Label)
            make.top.equalTo(stat4Label.snp_bottom)
        }
        stat5Label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat2Label)
            make.right.equalTo(stat2Label)
            make.top.equalTo(stat2Text.snp_bottom).offset(10)
        }
        stat5Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat5Label)
            make.right.equalTo(stat5Label)
            make.top.equalTo(stat5Label.snp_bottom)
        }
        stat6Label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat3Label)
            make.right.equalTo(stat3Label)
            make.top.equalTo(stat3Text.snp_bottom).offset(10)
        }
        stat6Text.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(stat6Label)
            make.right.equalTo(stat6Label)
            make.top.equalTo(stat6Label.snp_bottom)
        }
        table.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
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
}