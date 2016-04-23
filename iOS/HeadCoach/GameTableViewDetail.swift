
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
                weekLabel.text = "Week " + String(g.week!)
                if let opp = g.opp{
                oppLabel.text = "vs. " + opp
                }
                if let how = g.homeOrAway{
                howLabel.text = how
                }
                passLabel.text = "Passed " + String(g.passYds!) + "yds"
                recLabel.text = "Rec'd " + String(g.recYds!) + "yds"
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
        super.init(style: style, reuseIdentifier: "game")
        backgroundColor = UIColor.whiteColor()
        selectionStyle = .None
        background = UIView(frame: CGRectZero)
        background.alpha = 0.6
        contentView.addSubview(background)
        
        weekLabel = UILabel(frame: CGRectZero)
        weekLabel.textAlignment = .Left
        weekLabel.textColor = UIColor.blackColor()
        weekLabel.font = weekLabel.font.fontWithSize(14)
        contentView.addSubview(weekLabel)
        
        oppLabel = UILabel(frame: CGRectZero)
        oppLabel.textAlignment = .Left
        oppLabel.textColor = UIColor.blackColor()
        oppLabel.font = oppLabel.font.fontWithSize(14)
        contentView.addSubview(oppLabel)
        
        howLabel = UILabel(frame: CGRectZero)
        howLabel.textAlignment = .Left
        howLabel.textColor = UIColor.blackColor()
        howLabel.font = howLabel.font.fontWithSize(14)
        contentView.addSubview(howLabel)
        
        passLabel = UILabel(frame: CGRectZero)
        passLabel.textAlignment = .Left
        passLabel.textColor = UIColor.blackColor()
        passLabel.font = passLabel.font.fontWithSize(14)
        contentView.addSubview(passLabel)
        
        recLabel = UILabel(frame: CGRectZero)
        recLabel.textAlignment = .Left
        recLabel.textColor = UIColor.blackColor()
        recLabel.font = recLabel.font.fontWithSize(14)
        contentView.addSubview(recLabel)

        layoutViews()
    }

    func layoutViews() {
        background.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        weekLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(self).dividedBy(5)
            make.left.equalTo(self).offset(12)
        }

        oppLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(self).dividedBy(5)
            make.left.equalTo(weekLabel.snp_right)
        }

        howLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(self).dividedBy(5)
            make.left.equalTo(oppLabel.snp_right)
        }

        passLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(self).dividedBy(5)
            make.left.equalTo(howLabel.snp_right)
        }

        recLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(self).dividedBy(5)
            make.right.equalTo(self).offset(-12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}