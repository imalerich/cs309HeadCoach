
import Foundation
import UIKit
import SnapKit

class PlayerTableViewCell: UITableViewCell {
    
    var background: UIView!
    @IBOutlet var playerImage: UIImageView!
    var nameLabel: UILabel!
    var teamLabel: UILabel!
    var textContainer: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textContainer = UIView()
        
        nameLabel = UILabel()
        nameLabel.textAlignment = .Left
        nameLabel.sizeToFit()
        nameLabel.textColor = UIColor.blackColor()
        
        teamLabel = UILabel()
        teamLabel.textAlignment = .Left
        teamLabel.sizeToFit()
        teamLabel.textColor = UIColor.darkGrayColor()
        teamLabel.font = teamLabel.font.fontWithSize(12)
        
        playerImage = UIImageView()
        playerImage.layer.shadowOffset = CGSize(width: 0, height: -3)
        playerImage.layer.shadowOpacity = 0.5
        playerImage.layer.shadowRadius = 4
        
        contentView.addSubview(playerImage)
        contentView.addSubview(textContainer)
        textContainer.addSubview(teamLabel)
        textContainer.addSubview(nameLabel)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setPlayer(player: FDPlayer){
        nameLabel.text = player.name
        if(!player.fantasyPosition.isEmpty){
            teamLabel.text = player.fantasyPosition + " for " + player.team
        }else{
            teamLabel.text = player.team
        }
    }
    
    func setUp(){
        playerImage.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(5)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.left.equalTo(self.snp_left).offset(15)
            make.width.equalTo(30)
        })
        textContainer.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage!.snp_right).offset(10)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(self.snp_top).offset(10)
            make.bottom.equalTo(self.snp_bottom).offset(-10)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(textContainer.snp_left)
            make.width.equalTo(textContainer)
            make.bottom.equalTo(textContainer.snp_centerY)
            
        }
        teamLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(textContainer.snp_left)
            make.width.equalTo(textContainer)
            make.top.equalTo(textContainer.snp_centerY)
        }
    }
}
