
import UIKit
import SnapKit
import Foundation

class LiveGameTableViewCell: UITableViewCell{
    
    let position = UILabel()
    let name = UILabel()
    let points = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initViews(){
        position.textAlignment = .Left
        position.font = UIFont.systemFontOfSize(20)
        position.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        position.sizeToFit()
        
        name.textAlignment = .Left
        name.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        name.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        name.sizeToFit()
        
        points.textAlignment = .Left
        points.font = UIFont.systemFontOfSize(20)
        points.textColor = UIColor.footballColor(1)
        points.sizeToFit()
    }
    
    internal func layoutViews(){
        addSubview(position)
        position.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(position.snp_right).offset(5)
            make.centerY.equalTo(position)
        }
        addSubview(points)
        points.snp_makeConstraints { (make) in
            make.right.equalTo(self).inset(15)
            make.centerY.equalTo(self)
        }
    }
    
    func setPlayer(fdplayer: FDPlayer, hcplayer: HCPlayer, pts: UInt32, winner: Bool){
        position.text = HCPositionUtil.positionToString(hcplayer.position)
        name.text = fdplayer.name
        points.text = String(pts)
        backgroundColor = winner ? UIColor.footballColor(1).colorWithAlphaComponent(0.25) : UIColor.whiteColor()
//        name.textColor = winner ? UIColor.whiteColor().colorWithAlphaComponent(0.75) : UIColor.footballColor(1)
        points.textColor = name.textColor
    }
    
    
}