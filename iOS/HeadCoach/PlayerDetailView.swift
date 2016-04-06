
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
    var heightLabel: UILabel!
    var weightLabel: UILabel!
    var heightText: UILabel!
    var weightText:UILabel!
    var table: UITableView!
    var statusLabel: UILabel!
    var statusText: UILabel!
    var statusTextContainer: UIView!
    var detailContainer: UIView!
    var byeWeekLabel: UILabel!
    var byeWeekText: UILabel!
    var rankLabel: UILabel!
    var rankText: UILabel!
    var weekPtsLabel1: UILabel!
    var weekPtsLabel2: UILabel!
    var weekPtsText1: UILabel!
    var weekPtsText2: UILabel!
    
    var tempTradeButton: UIButton!
    
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
        rankText.text = String(arc4random_uniform(100) + 1)
        byeWeekText.text = String(arc4random_uniform(12) + 1)
        weekPtsText1.text = String(arc4random_uniform(40)) + " pts."
        weekPtsText2.text = String(arc4random_uniform(40)) + " pts."
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
    
    func addCustomView(){
        backgroundColor = UIColor.whiteColor()
        
        detailContainer = UIView()
        detailContainer.backgroundColor = UIColor.whiteColor()
        detailContainer.layer.masksToBounds = true
        detailContainer.layer.cornerRadius = 4
        detailContainer.layer.borderWidth = 5
        detailContainer.layer.borderColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1).CGColor
        addSubview(detailContainer)
        
        circle = UIView()
        circle.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        circle.layer.masksToBounds = true
        circle.layer.cornerRadius = 37;
        addSubview(circle)
        
        headerLabelContainer = UIView();
        headerLabelContainer.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        headerLabelContainer.layer.masksToBounds = true
        headerLabelContainer.layer.cornerRadius = 4
        addSubview(headerLabelContainer)
        
        byeWeekLabel = UILabel()
        byeWeekLabel.textAlignment = .Center
        byeWeekLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        byeWeekLabel.font = byeWeekLabel.font.fontWithSize(14)
        byeWeekLabel.sizeToFit()
        byeWeekLabel.text = "Bye Week"
        detailContainer.addSubview(byeWeekLabel)
        
        byeWeekText = UILabel()
        byeWeekText.textAlignment = .Center
        byeWeekText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        byeWeekText.font = byeWeekText.font.fontWithSize(14)
        byeWeekText.sizeToFit()
        detailContainer.addSubview(byeWeekText)
        
        rankLabel = UILabel()
        rankLabel.textAlignment = .Center
        rankLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        rankLabel.font = rankLabel.font.fontWithSize(14)
        rankLabel.sizeToFit()
        rankLabel.text = "Rank"
        detailContainer.addSubview(rankLabel)
        
        rankText = UILabel()
        rankText.textAlignment = .Center
        rankText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        rankText.font = rankText.font.fontWithSize(14)
        rankText.sizeToFit()
        detailContainer.addSubview(rankText)
        
        weekPtsLabel1 = UILabel()
        weekPtsLabel1.textAlignment = .Center
        weekPtsLabel1.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        weekPtsLabel1.font = weekPtsLabel1.font.fontWithSize(14)
        weekPtsLabel1.sizeToFit()
        let random = arc4random_uniform(12)
        weekPtsLabel1.text = "Week " + String(random)
        detailContainer.addSubview(weekPtsLabel1)
        
        weekPtsLabel2 = UILabel()
        weekPtsLabel2.textAlignment = .Center
        weekPtsLabel2.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        weekPtsLabel2.font = weekPtsLabel2.font.fontWithSize(14)
        weekPtsLabel2.sizeToFit()
        weekPtsLabel2.text = "Week " + String(random+1)
        detailContainer.addSubview(weekPtsLabel2)
        
        weekPtsText1 = UILabel()
        weekPtsText1.textAlignment = .Center
        weekPtsText1.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        weekPtsText1.font = weekPtsText1.font.fontWithSize(14)
        weekPtsText1.sizeToFit()
        detailContainer.addSubview(weekPtsText1)
        
        weekPtsText2 = UILabel()
        weekPtsText2.textAlignment = .Center
        weekPtsText2.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        weekPtsText2.font = weekPtsText2.font.fontWithSize(14)
        weekPtsText2.sizeToFit()
        detailContainer.addSubview(weekPtsText2)

        nameLabel = UILabel()
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = nameLabel.font.fontWithSize(16)
        nameLabel.sizeToFit()
        headerLabelContainer.addSubview(nameLabel)
        
        numLabel = UILabel()
        numLabel.textAlignment = .Left
        numLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        numLabel.font = numLabel.font.fontWithSize(14)
        numLabel.sizeToFit()
        headerLabelContainer.addSubview(numLabel)
        
        teamLabel = UILabel()
        teamLabel.textAlignment = .Left
        teamLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        teamLabel.sizeToFit()
        teamLabel.font = teamLabel.font.fontWithSize(14)
        headerLabelContainer.addSubview(teamLabel)
        
        heightLabel = UILabel()
        heightLabel.textAlignment = .Left
        heightLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        heightLabel.sizeToFit()
        heightLabel.text = "Height"
        heightLabel.font = heightLabel.font.fontWithSize(10)
        headerLabelContainer.addSubview(heightLabel)
        
        weightLabel = UILabel()
        weightLabel.textAlignment = .Left
        weightLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        weightLabel.sizeToFit()
        weightLabel.text = "Weight"
        weightLabel.font = weightLabel.font.fontWithSize(10)
        headerLabelContainer.addSubview(weightLabel)
        
        weightText = UILabel()
        weightText.textAlignment = .Left
        weightText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        weightText.sizeToFit()
        weightText.font = weightText.font.fontWithSize(10)
        headerLabelContainer.addSubview(weightText)
        
        heightText = UILabel()
        heightText.textAlignment = .Left
        heightText.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        heightText.sizeToFit()
        heightText.font = heightText.font.fontWithSize(10)
        headerLabelContainer.addSubview(heightText)
        
        statusLabel = UILabel()
        statusLabel.font = statusLabel.font.fontWithSize(10)
        statusLabel.text = "Status"
        headerLabelContainer.addSubview(statusLabel)
        
        statusTextContainer = UIView()
        statusTextContainer.layer.masksToBounds = true
        statusTextContainer.layer.cornerRadius = 3
        headerLabelContainer.addSubview(statusTextContainer)
        
        statusText = UILabel()
        statusText.font = statusText.font.fontWithSize(10)
        statusText.textColor = UIColor.whiteColor()
        headerLabelContainer.addSubview(statusText)
        
        tempTradeButton = UIButton.init(type: UIButtonType.System)
        tempTradeButton.setTitle("Trade", forState: UIControlState.Normal)
        tempTradeButton.titleLabel!.font = tempTradeButton.titleLabel!.font.fontWithSize(14)
        tempTradeButton.titleLabel!.textAlignment = .Center
        tempTradeButton.sizeToFit()
        tempTradeButton.setTitleColor(UIColor.init(red: 0, green: 0, blue: 0.8, alpha: 1), forState: UIControlState.Normal)
        headerLabelContainer.addSubview(tempTradeButton)
        
        playerImage = UIImageView()
        playerImage.layer.shadowOffset = CGSize(width: 0, height: -3)
        playerImage.layer.shadowOpacity = 0.5
        playerImage.layer.shadowRadius = 4
        playerImage.layer.masksToBounds=true
        playerImage.layer.borderWidth = 1
        playerImage.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1 ).CGColor
        playerImage.layer.cornerRadius = 32
        addSubview(playerImage)
        
        table = UITableView()
        addSubview(table)
        
        setConstraints()
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
            make.left.equalTo(self.snp_left).inset(40)
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
            make.top.equalTo(nameLabel.snp_bottom)
        }
        weightLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(headerLabelContainer).inset(5)
            make.left.equalTo(playerImage.snp_right).offset(5)
        }
        heightLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(weightLabel.snp_top)
            make.left.equalTo(playerImage.snp_right).offset(5)
        }
        weightText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(weightLabel.snp_right).offset(5)
            make.bottom.equalTo(headerLabelContainer).inset(5)
        }
        heightText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(weightText.snp_left)
            make.bottom.equalTo(weightText.snp_top)
        }
        statusText.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(headerLabelContainer).inset(8)
            make.bottom.equalTo(headerLabelContainer).inset(8)
        }
        statusTextContainer.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(statusText.snp_right).offset(2)
            make.left.equalTo(statusText.snp_left).offset(-2)
            make.top.equalTo(statusText.snp_top).offset(-2)
            make.bottom.equalTo(statusText.snp_bottom).offset(2)
        }
        statusLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(statusText.snp_left).offset(-5)
            make.bottom.equalTo(headerLabelContainer).inset(8)
        }
        tempTradeButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(statusText.snp_top)
            make.right.equalTo(headerLabelContainer).inset(8)
        }
        detailContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerLabelContainer.snp_bottom).inset(15)
            make.left.equalTo(self.snp_left).inset(20)
            make.right.equalTo(self.snp_right).inset(20)
            make.bottom.equalTo(self.snp_bottom).inset(20)
        }
        byeWeekLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer.snp_centerX)
            make.top.equalTo(headerLabelContainer.snp_bottom).offset(10)
        }
        byeWeekText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(byeWeekLabel)
            make.right.equalTo(byeWeekLabel)
            make.top.equalTo(byeWeekLabel.snp_bottom)
        }
        rankLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(detailContainer.snp_centerX)
            make.right.equalTo(detailContainer)
            make.top.equalTo(headerLabelContainer.snp_bottom).offset(10)
        }
        rankText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(rankLabel)
            make.right.equalTo(rankLabel)
            make.top.equalTo(rankLabel.snp_bottom)
        }
        weekPtsLabel1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(byeWeekLabel)
            make.right.equalTo(byeWeekLabel)
            make.top.equalTo(byeWeekText.snp_bottom).offset(10)
        }
        weekPtsText1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(weekPtsLabel1)
            make.right.equalTo(weekPtsLabel1)
            make.top.equalTo(weekPtsLabel1.snp_bottom)
        }
        weekPtsLabel2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(rankLabel)
            make.right.equalTo(rankLabel)
            make.top.equalTo(rankText.snp_bottom).offset(10)
        }
        weekPtsText2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(weekPtsLabel2)
            make.right.equalTo(weekPtsLabel2)
            make.top.equalTo(weekPtsLabel2.snp_bottom)
        }
        table.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()

    }
}