
import Foundation
import UIKit
import SnapKit

class TradeDetailView: UIView {
    
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
        setNeedsLayout()
        tradeTitleLabel.text = user1.name + wtt
        
        nameTextU1.text = user1.name
        nameTextU2.text = user2.name
        nameTextP1.text = player1.name
        nameTextP2.text = player2.name
        
        stat1Label.text = "Pos"
        stat1TextP1.text = player1.position
        stat1TextP2.text = player2.position
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
        declineButton.titleLabel!.text = "Decline"
        declineButton.setTitleColor(UIColor.init(red: 1, green: 0.2, blue: 0.2, alpha: 1), forState: UIControlState.Normal)
        addSubview(declineButton)
        
        acceptButton = UIButton.init(type: UIButtonType.System)
        acceptButton.titleLabel!.text = "Accept"
        acceptButton.setTitleColor(UIColor.init(red: 0.2, green: 1, blue: 0.2, alpha: 1), forState: UIControlState.Normal)
        addSubview(acceptButton)
        
        alterButton = UIButton.init(type: UIButtonType.System)
        alterButton.titleLabel!.text = "Alter"
        addSubview(alterButton)
        
        nameTextU1 = UILabel.init()
        nameTextU1.textAlignment = .Center
        nameTextU1.textColor = UIColor.darkGrayColor()
        nameTextU1.font = nameTextU1.font.fontWithSize(12)
        addSubview(nameTextU1)
        
        nameTextU2 = UILabel.init()
        nameTextU2.textAlignment = .Center
        nameTextU2.textColor = UIColor.darkGrayColor()
        nameTextU2.font = nameTextU2.font.fontWithSize(12)
        addSubview(nameTextU2)
    
        imageP1 = UIImageView.init()
        imageP1 = UIImageView()
        imageP1.layer.shadowOffset = CGSize(width: 0, height: -3)
        imageP1.layer.shadowOpacity = 0.5
        imageP1.layer.shadowRadius = 4
        imageP1.layer.masksToBounds=true
        self.addSubview(imageP1)
        
        imageP2 = UIImageView.init()
        imageP2 = UIImageView()
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
        stat1Label.textColor = UIColor.blackColor()
        stat1Label.font = stat1Label.font.fontWithSize(12)
        addSubview(stat1Label)
        
        stat1TextP1 = UILabel.init()
        stat1TextP1.textAlignment = .Center
        stat1TextP1.textColor = UIColor.darkGrayColor()
        stat1TextP1.font = stat1TextP1.font.fontWithSize(12)
        addSubview(stat1TextP1)
        
        stat1TextP2 = UILabel.init()
        stat1TextP2.textAlignment = .Center
        stat1TextP2.textColor = UIColor.darkGrayColor()
        stat1TextP2.font = stat1TextP2.font.fontWithSize(12)
        addSubview(stat1TextP2)
        
        stat2Label = UILabel.init()
        stat2Label.textAlignment = .Center
        stat2Label.textColor = UIColor.blackColor()
        stat2Label.font = stat2Label.font.fontWithSize(12)
        addSubview(stat2Label)
        
        stat2TextP1 = UILabel.init()
        stat2TextP1.textAlignment = .Center
        stat2TextP1.textColor = UIColor.darkGrayColor()
        stat2TextP1.font = stat2TextP1.font.fontWithSize(12)
        addSubview(stat2TextP1)
        
        stat2TextP2 = UILabel.init()
        stat2TextP2.textAlignment = .Center
        stat2TextP2.textColor = UIColor.darkGrayColor()
        stat2TextP2.font = stat2TextP2.font.fontWithSize(12)
        addSubview(stat2TextP2)
        
        stat3Label = UILabel.init()
        stat3Label.textAlignment = .Center
        stat3Label.textColor = UIColor.blackColor()
        stat3Label.font = stat3Label.font.fontWithSize(12)
        addSubview(stat3Label)
        
        stat3TextP1 = UILabel.init()
        stat3TextP1.textAlignment = .Center
        stat3TextP1.textColor = UIColor.darkGrayColor()
        stat3TextP1.font = stat3TextP1.font.fontWithSize(12)
        addSubview(stat3TextP1)
        
        stat3TextP2 = UILabel.init()
        stat3TextP2.textAlignment = .Center
        stat3TextP2.textColor = UIColor.darkGrayColor()
        stat3TextP2.font = stat3TextP2.font.fontWithSize(12)
        addSubview(stat3TextP2)
        
        stat4Label = UILabel.init()
        stat4Label.textAlignment = .Center
        stat4Label.textColor = UIColor.blackColor()
        stat4Label.font = stat4Label.font.fontWithSize(12)
        addSubview(stat4Label)
        
        stat4TextP1 = UILabel.init()
        stat4TextP1.textAlignment = .Center
        stat4TextP1.textColor = UIColor.darkGrayColor()
        stat4TextP1.font = stat4TextP1.font.fontWithSize(12)
        addSubview(stat4TextP1)
        
        stat4TextP2 = UILabel.init()
        stat4TextP2.textAlignment = .Center
        stat4TextP2.textColor = UIColor.darkGrayColor()
        stat4TextP2.font = stat4TextP2.font.fontWithSize(12)
        addSubview(stat4TextP2)
        
        setConstraints()
    }
    
    func setConstraints(){
        tradeTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(0.1)
        }
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
    }
}