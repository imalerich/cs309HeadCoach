import Foundation
import UIKit
import SnapKit

class GameStatView: UIView {
    
    var week: UILabel!
    var opp: UILabel!
    var points: UILabel!
    var started: UILabel!
    
    func setGame(game: Game){
        setTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
        week.text = String(game.week!)
        opp.text = game.opp
        points.text = String(32.20)
        started.text = game.started
    }

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
    
    func addCustomView(){
        week = UILabel()
        week.textColor = UIColor.blackColor()
        week.font = week.font.fontWithSize(14)
        week.sizeToFit()
        week.textAlignment = .Center
        addSubview(week)
        
        opp = UILabel()
        opp.textColor = UIColor.blackColor()
        opp.font = opp.font.fontWithSize(14)
        opp.sizeToFit()
        opp.textAlignment = .Center
        addSubview(opp)
        
        points = UILabel()
        points.textColor = UIColor.blackColor()
        points.font = points.font.fontWithSize(14)
        points.sizeToFit()
        points.textAlignment = .Center
        addSubview(points)
        
        started = UILabel()
        started.textColor = UIColor.blackColor()
        started.font = started.font.fontWithSize(14)
        started.sizeToFit()
        started.textAlignment = .Center
        addSubview(started)
        setConstraints()
    }
    
    func setConstraints(){
        week.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.height.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(self).dividedBy(4)
        }
        opp.snp_makeConstraints { (make) in
            make.left.equalTo(week.snp_right)
            make.height.equalTo(week)
            make.top.equalTo(week)
            make.width.equalTo(week)
        }
        points.snp_makeConstraints { (make) in
            make.left.equalTo(opp.snp_right)
            make.height.equalTo(week)
            make.top.equalTo(week)
            make.width.equalTo(week)
        }
        started.snp_makeConstraints { (make) in
            make.left.equalTo(points.snp_right)
            make.height.equalTo(week)
            make.top.equalTo(week)
            make.width.equalTo(week)
        }
    }

    func setTextColor(color: UIColor){
        week.textColor = color
        opp.textColor = color
        points.textColor = color
        started.textColor = color
    }
}