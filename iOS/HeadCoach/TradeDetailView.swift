
import Foundation
import UIKit
import SnapKit

class TradeDetailView: UIView {
    
    var p1ID: Int!
    var p2ID: Int!
    var tradeTitleLabel: UILabel!
    var declineButton: UIButton!
    var alterButton: UIButton!
    var acceptButton: UIButton!
    var recommendLabel: UILabel!
    var nameTextU1: UILabel!
    var nameTextU2: UILabel!
    @IBOutlet var imageP1: UIImageView!
    @IBOutlet var imageP2: UIImageView!
    var nameTextP1: UILabel!
    var nameTextP2: UILabel!
    var horizontalDivider: UIView!
    var verticalDivider: UIView!
    var stat1Label: UILabel!
    var stat1TextP1: UILabel!
    var stat1TextP2: UILabel!
    var stat2Label: UILabel!
    var stat2TextP1: UILabel!
    var stat2TextP2: UILabel!
    var stat3Label: UILabel!
    var stat3TextP1: UILabel!
    var stat3TextP2: UILabel!
    var stat4Label: UILabel!
    var stat4TextP1: UILabel!
    var stat4TextP2: UILabel!
    var stat5Label: UILabel!
    var stat5TextP1: UILabel!
    var stat5TextP2: UILabel!
    var analysisLabel: UILabel!
    
    let wtt = " wants to trade!"
    
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
    
    func setInfo(user1: HCUser, user2: HCUser, player1: FDPlayer, player2: FDPlayer){
        p1ID = player1.id
        p2ID = player2.id
        tradeTitleLabel.text = user1.name + wtt
        
        nameTextU1.text = user1.name
        nameTextU2.text = user2.name
        nameTextP1.text = player1.name
        nameTextP2.text = player2.name
        
        stat1Label.text = "Pos"
        stat1TextP1.text = player1.position
        stat1TextP2.text = player2.position
        setNeedsLayout()
    }
    
    func setPlayer1(player: FDPlayer){
        p1ID = player.id
        nameTextP1.text = player.name
        stat1TextP1.text = player.position
        imageP1.load(player.photoURL)
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
        if(p1ID == id){
            stat2TextP1.text = String(passYds)
            stat3TextP1.text = String(rushYds)
            stat4TextP1.text = String(tds)
            stat5TextP1.text = String(arc4random_uniform(40))
        }else{
            stat2TextP2.text = String(passYds)
            stat3TextP2.text = String(rushYds)
            stat4TextP2.text = String(tds)
            stat5TextP2.text = String(arc4random_uniform(40))
        }
        setNeedsLayout()
    }
    
    func addCustomView(){
        backgroundColor = UIColor.whiteColor()
        
        tradeTitleLabel = UILabel()
        tradeTitleLabel.textAlignment = .Center
        tradeTitleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        tradeTitleLabel.font = tradeTitleLabel.font.fontWithSize(16)
        tradeTitleLabel.text = wtt
        tradeTitleLabel.sizeToFit()
        addSubview(tradeTitleLabel)
        
        declineButton = UIButton.init(type: UIButtonType.System)
        declineButton.setTitle("Decline", forState: UIControlState.Normal)
        declineButton.titleLabel!.font = declineButton.titleLabel!.font.fontWithSize(14)
        declineButton.titleLabel!.textAlignment = .Center
        declineButton.sizeToFit()
        declineButton.setTitleColor(UIColor.init(red: 1, green: 0.2, blue: 0.2, alpha: 1), forState: UIControlState.Normal)
        addSubview(declineButton)
        
        acceptButton = UIButton.init(type: UIButtonType.System)
        acceptButton.setTitle("Accept", forState: UIControlState.Normal)
        acceptButton.titleLabel!.font = acceptButton.titleLabel!.font.fontWithSize(14)
        acceptButton.titleLabel!.textAlignment = .Center
        acceptButton.sizeToFit()
        acceptButton.setTitleColor(UIColor.init(red: 0.2, green: 1, blue: 0.2, alpha: 1), forState: UIControlState.Normal)
        addSubview(acceptButton)
        
        alterButton = UIButton.init(type: UIButtonType.System)
        alterButton.setTitle("Alter", forState: UIControlState.Normal)
        alterButton.titleLabel!.font = alterButton.titleLabel!.font.fontWithSize(14)
        alterButton.titleLabel!.textAlignment = .Center
        alterButton.sizeToFit()
        addSubview(alterButton)
        
        recommendLabel = UILabel.init()
        recommendLabel.text = "Recommended"
        recommendLabel.textAlignment = .Center
        recommendLabel.textColor = UIColor.lightGrayColor()
        recommendLabel.font = recommendLabel.font.fontWithSize(8)
        addSubview(recommendLabel)
        
        nameTextU1 = UILabel.init()
        nameTextU1.textAlignment = .Center
        nameTextU1.textColor = UIColor.darkGrayColor()
        nameTextU1.font = nameTextU1.font.fontWithSize(14)
        addSubview(nameTextU1)
        
        nameTextU2 = UILabel.init()
        nameTextU2.textAlignment = .Center
        nameTextU2.textColor = UIColor.darkGrayColor()
        nameTextU2.font = nameTextU2.font.fontWithSize(14)
        addSubview(nameTextU2)
    
        imageP1 = UIImageView.init()
        imageP1.backgroundColor = UIColor.blackColor()
        imageP1.layer.shadowOffset = CGSize(width: 0, height: -3)
        imageP1.layer.shadowOpacity = 0.5
        imageP1.layer.shadowRadius = 4
        imageP1.layer.masksToBounds=true
        self.addSubview(imageP1)
        
        imageP2 = UIImageView.init()
        imageP2.backgroundColor = UIColor.blackColor()
        imageP2.layer.shadowOffset = CGSize(width: 0, height: -3)
        imageP2.layer.shadowOpacity = 0.5
        imageP2.layer.shadowRadius = 4
        imageP2.layer.masksToBounds=true
        self.addSubview(imageP2)
        
        nameTextP1 = UILabel.init()
        nameTextP1.textAlignment = .Center
        nameTextP1.textColor = UIColor.darkGrayColor()
        nameTextP1.font = nameTextP1.font.fontWithSize(12)
        addSubview(nameTextP1)
        
        nameTextP2 = UILabel.init()
        nameTextP2.textAlignment = .Center
        nameTextP2.textColor = UIColor.darkGrayColor()
        nameTextP2.font = nameTextP2.font.fontWithSize(12)
        addSubview(nameTextP2)
        
        horizontalDivider = UIView.init()
        horizontalDivider.backgroundColor = UIColor.lightGrayColor()
        addSubview(horizontalDivider)
        
        verticalDivider = UIView.init()
        verticalDivider.backgroundColor = UIColor.lightGrayColor()
        addSubview(verticalDivider)
        
        stat1Label = UILabel.init()
        stat1Label.textAlignment = .Center
        stat1Label.textColor = UIColor.darkGrayColor()
        stat1Label.font = stat1Label.font.fontWithSize(12)
        addSubview(stat1Label)
        
        stat1TextP1 = UILabel.init()
        stat1TextP1.textAlignment = .Center
        stat1TextP1.textColor = UIColor.blackColor()
        stat1TextP1.font = stat1TextP1.font.fontWithSize(12)
        addSubview(stat1TextP1)
        
        stat1TextP2 = UILabel.init()
        stat1TextP2.textAlignment = .Center
        stat1TextP2.textColor = UIColor.blackColor()
        stat1TextP2.font = stat1TextP2.font.fontWithSize(12)
        addSubview(stat1TextP2)
        
        stat2Label = UILabel.init()
        stat2Label.textAlignment = .Center
        stat2Label.textColor = UIColor.darkGrayColor()
        stat2Label.font = stat2Label.font.fontWithSize(12)
        addSubview(stat2Label)
        
        stat2TextP1 = UILabel.init()
        stat2TextP1.textAlignment = .Center
        stat2TextP1.textColor = UIColor.blackColor()
        stat2TextP1.font = stat2TextP1.font.fontWithSize(12)
        addSubview(stat2TextP1)
        
        stat2TextP2 = UILabel.init()
        stat2TextP2.textAlignment = .Center
        stat2TextP2.textColor = UIColor.blackColor()
        stat2TextP2.font = stat2TextP2.font.fontWithSize(12)
        addSubview(stat2TextP2)
        
        stat3Label = UILabel.init()
        stat3Label.textAlignment = .Center
        stat3Label.textColor = UIColor.darkGrayColor()
        stat3Label.font = stat3Label.font.fontWithSize(12)
        addSubview(stat3Label)
        
        stat3TextP1 = UILabel.init()
        stat3TextP1.textAlignment = .Center
        stat3TextP1.textColor = UIColor.blackColor()
        stat3TextP1.font = stat3TextP1.font.fontWithSize(12)
        addSubview(stat3TextP1)
        
        stat3TextP2 = UILabel.init()
        stat3TextP2.textAlignment = .Center
        stat3TextP2.textColor = UIColor.blackColor()
        stat3TextP2.font = stat3TextP2.font.fontWithSize(12)
        addSubview(stat3TextP2)
        
        stat4Label = UILabel.init()
        stat4Label.textAlignment = .Center
        stat4Label.textColor = UIColor.darkGrayColor()
        stat4Label.font = stat4Label.font.fontWithSize(12)
        addSubview(stat4Label)
        
        stat4TextP1 = UILabel.init()
        stat4TextP1.textAlignment = .Center
        stat4TextP1.textColor = UIColor.blackColor()
        stat4TextP1.font = stat4TextP1.font.fontWithSize(12)
        addSubview(stat4TextP1)
        
        stat4TextP2 = UILabel.init()
        stat4TextP2.textAlignment = .Center
        stat4TextP2.textColor = UIColor.blackColor()
        stat4TextP2.font = stat4TextP2.font.fontWithSize(12)
        addSubview(stat4TextP2)
        
        stat5Label = UILabel.init()
        stat5Label.textAlignment = .Center
        stat5Label.textColor = UIColor.darkGrayColor()
        stat5Label.font = stat5Label.font.fontWithSize(12)
        addSubview(stat5Label)
        
        stat5TextP1 = UILabel.init()
        stat5TextP1.textAlignment = .Center
        stat5TextP1.textColor = UIColor.blackColor()
        stat5TextP1.font = stat5TextP1.font.fontWithSize(12)
        addSubview(stat5TextP1)
        
        stat5TextP2 = UILabel.init()
        stat5TextP2.textAlignment = .Center
        stat5TextP2.textColor = UIColor.blackColor()
        stat5TextP2.font = stat5TextP2.font.fontWithSize(12)
        addSubview(stat5TextP2)
        
        analysisLabel = UILabel.init()
        analysisLabel.text = "Analysis"
        analysisLabel.textAlignment = .Center
        analysisLabel.textColor = UIColor.blackColor()
        analysisLabel.font = analysisLabel.font.fontWithSize(12)
        addSubview(analysisLabel)
        
        nameTextU1.text = "Davor Civsa"
        nameTextU2.text = "You"
        nameTextP2.text = "Supa Dupa Long Name"
        stat1Label.text = "POS"
        stat2Label.text = "PASS YDS"
        stat3Label.text = "RUSH YDS"
        stat4Label.text = "TD"
        stat5Label.text = "PTS/GM"
        
        setConstraints()
    }
    
    func setConstraints(){
        tradeTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(0.05)
        }
        declineButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(tradeTitleLabel.snp_bottom)
            make.height.equalTo(self.snp_height).multipliedBy(0.05)
            make.width.equalTo(self.snp_width).dividedBy(3)
        }
        alterButton.snp_makeConstraints { (make) in
            make.left.equalTo(declineButton.snp_right)
            make.top.equalTo(declineButton.snp_top)
            make.height.equalTo(declineButton.snp_height)
            make.width.equalTo(declineButton.snp_width)
        }
        acceptButton.snp_makeConstraints { (make) in
            make.left.equalTo(alterButton.snp_right)
            make.top.equalTo(declineButton)
            make.height.equalTo(declineButton)
            make.width.equalTo(declineButton)
        }
        recommendLabel.snp_makeConstraints { (make) in
            make.top.equalTo(declineButton.snp_bottom)
            make.left.equalTo(acceptButton)
            make.width.equalTo(acceptButton)
            make.height.equalTo(self.snp_height).multipliedBy(0.025)
        }
        nameTextU1.snp_makeConstraints { (make) in
            make.top.equalTo(recommendLabel.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(self.snp_height).multipliedBy(0.075)
        }
        nameTextU2.snp_makeConstraints { (make) in
            make.top.equalTo(nameTextU1.snp_top)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(nameTextU1)
        }
        horizontalDivider.snp_makeConstraints { (make) in
            make.bottom.equalTo(nameTextU1.snp_bottom)
            make.width.equalTo(self.snp_width)
            make.height.equalTo(1)
        }
        verticalDivider.snp_makeConstraints { (make) in
            make.top.equalTo(nameTextU1.snp_bottom)
            make.height.equalTo(self.snp_height)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(1)
        }
        imageP1.snp_makeConstraints { (make) in
            make.top.equalTo(nameTextU1.snp_bottom).offset(5)
            make.centerX.equalTo(self.snp_centerX).dividedBy(2)
            make.height.equalTo(self.snp_height).multipliedBy(0.1)
            make.width.equalTo(imageP1.snp_height).multipliedBy(0.72)
        }
        imageP2.snp_makeConstraints { (make) in
            make.top.equalTo(imageP1)
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1.5)
            make.width.equalTo(imageP1)
            make.height.equalTo(imageP1)
        }
        nameTextP1.snp_makeConstraints { (make) in
            make.top.equalTo(imageP1.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(self.snp_height).multipliedBy(0.05)
        }
        nameTextP2.snp_makeConstraints { (make) in
            make.top.equalTo(nameTextP1)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(nameTextP1)
        }
        stat1Label.snp_makeConstraints { (make) in
            make.top.equalTo(nameTextP1.snp_bottom).offset(10)
            make.centerX.equalTo(self.snp_centerX)
        }
        stat2Label.snp_makeConstraints { (make) in
            make.top.equalTo(stat1Label.snp_bottom).offset(5)
            make.centerX.equalTo(stat1Label)
        }
        stat3Label.snp_makeConstraints { (make) in
            make.top.equalTo(stat2Label.snp_bottom).offset(5)
            make.centerX.equalTo(stat2Label)
        }
        stat4Label.snp_makeConstraints { (make) in
            make.top.equalTo(stat3Label.snp_bottom).offset(5)
            make.centerX.equalTo(stat3Label)
        }
        stat5Label.snp_makeConstraints { (make) in
            make.top.equalTo(stat4Label.snp_bottom).offset(5)
            make.centerX.equalTo(stat3Label)
        }
        analysisLabel.snp_makeConstraints { (make) in
            make.top.equalTo(stat5Label.snp_bottom).offset(5)
            make.centerX.equalTo(stat1Label)
        }
        stat1TextP1.snp_makeConstraints { (make) in
            make.top.equalTo(stat1Label)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(stat1Label)
        }
        stat1TextP2.snp_makeConstraints { (make) in
            make.top.equalTo(stat1Label)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self)
            make.height.equalTo(stat1Label)
        }
        stat2TextP1.snp_makeConstraints { (make) in
            make.top.equalTo(stat2Label)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(stat2Label)
        }
        stat2TextP2.snp_makeConstraints { (make) in
            make.top.equalTo(stat2Label)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self)
            make.height.equalTo(stat2Label)
        }
        stat3TextP1.snp_makeConstraints { (make) in
            make.top.equalTo(stat3Label)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(stat3Label)
        }
        stat3TextP2.snp_makeConstraints { (make) in
            make.top.equalTo(stat3Label)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self)
            make.height.equalTo(stat3Label)
        }
        stat4TextP1.snp_makeConstraints { (make) in
            make.top.equalTo(stat4Label)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(stat4Label)
        }
        stat4TextP2.snp_makeConstraints { (make) in
            make.top.equalTo(stat4Label)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self)
            make.height.equalTo(stat4Label)
        }
        stat5TextP1.snp_makeConstraints { (make) in
            make.top.equalTo(stat5Label)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(stat5TextP2)
        }
        stat5TextP2.snp_makeConstraints { (make) in
            make.top.equalTo(stat5Label)
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self)
            make.height.equalTo(stat5TextP2)
        }
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
    }
}