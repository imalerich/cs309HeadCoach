
import Foundation
import UIKit
import SnapKit

class GameTableViewDetail: UITableViewCell {
    
    var background: UIView!
    var weekLabel: UILabel!
    var oppLabel: UILabel!
    var howLabel: UILabel!
    var passLabel: UILabel!
    var recLabel: UILabel!
    
    var game: Game? {
        didSet{
            if let g = game{
                weekLabel.text = "Week " + String(g.week)
                oppLabel.text = "vs. " + g.opp
                howLabel.text = "at " + g.homeOrAway
                passLabel.text = "Passed " + String(g.passYds) + "yds"
                recLabel.text = "Rec'd " + String(g.recYds) + "yds"
                //
                //                if let url = NSURL(string: p.imageURL){
                //                    if let data = NSData(contentsOfURL: url){
                //                        playerImage.image = UIImage(data: data);
                //                    }
                //                }
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        background = UIView(frame: CGRectZero)
        background.alpha = 0.6
        contentView.addSubview(background)
        
        weekLabel = UILabel(frame: CGRectZero)
        weekLabel.textAlignment = .Left
        weekLabel.textColor = UIColor.blackColor()
        weekLabel.font = weekLabel.font.fontWithSize(8)
        contentView.addSubview(weekLabel)
        
        oppLabel = UILabel(frame: CGRectZero)
        oppLabel.textAlignment = .Left
        oppLabel.textColor = UIColor.blackColor()
        oppLabel.font = oppLabel.font.fontWithSize(8)
        contentView.addSubview(oppLabel)
        
        howLabel = UILabel(frame: CGRectZero)
        howLabel.textAlignment = .Left
        howLabel.textColor = UIColor.blackColor()
        howLabel.font = howLabel.font.fontWithSize(8)
        contentView.addSubview(howLabel)
        
        passLabel = UILabel(frame: CGRectZero)
        passLabel.textAlignment = .Left
        passLabel.textColor = UIColor.blackColor()
        passLabel.font = passLabel.font.fontWithSize(8)
        contentView.addSubview(passLabel)
        
        recLabel = UILabel(frame: CGRectZero)
        recLabel.textAlignment = .Left
        recLabel.textColor = UIColor.blackColor()
        recLabel.font = recLabel.font.fontWithSize(8)
        contentView.addSubview(recLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        background.frame = CGRectMake(0, 0, frame.width, frame.height)
        weekLabel.frame = CGRectMake(15, 5, 40, frame.height)
        oppLabel.frame = CGRectMake(CGRectGetMaxX(weekLabel.frame), 5, 40, frame.height)
        howLabel.frame = CGRectMake(CGRectGetMaxX(oppLabel.frame) + 5, 5, 40, frame.height)
        passLabel.frame = CGRectMake(CGRectGetMaxX(howLabel.frame) + 5, 5, 50, frame.height)
        recLabel.frame = CGRectMake(CGRectGetMaxX(passLabel.frame) + 5, 5, 50, frame.height)
    }
}