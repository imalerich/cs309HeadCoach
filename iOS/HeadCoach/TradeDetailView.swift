
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
    var user2NameText: UILabel!
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
    
    func setInfo(player1: HCPlayer, player2: HCPlayer){
        setNeedsLayout()
    }
    
    func addCustomView(){
        backgroundColor = UIColor.whiteColor()
        
        tradeTitleLabel = UILabel()
        tradeTitleLabel.textAlignment = .Center
        tradeTitleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        tradeTitleLabel.font = tradeTitleLabel.font.fontWithSize(20)
        tradeTitleLabel.sizeToFit()
        addSubview(tradeTitleLabel)
        
        setConstraints()
    }
    
    func setConstraints(){
        tradeTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(self.snp_top).inset(10)
        }
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
    }
}