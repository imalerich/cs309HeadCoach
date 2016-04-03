//
//  HCLeagueTableViewCell.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class HCLeagueTableViewCell: UITableViewCell
{
    let userImage = UIImageView()
    let userName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(userImage)
        self.addSubview(userName)
        userImage.layer.cornerRadius = 15
        userImage.layer.masksToBounds = true
        userImage.layer.borderColor = UIColor.blackColor().CGColor
        userImage.layer.borderWidth = 2
        //TODO add actual images
        userImage.load("https://yt3.ggpht.com/-9JtIWfELi1A/AAAAAAAAAAI/AAAAAAAAAAA/sY8X2YGMGjU/s900-c-k-no/photo.jpg")
        userImage.snp_makeConstraints { (make) in
            make.left.lessThanOrEqualTo(5)
            make.size.equalTo(CGSizeMake(50, 50))
            make.top.lessThanOrEqualTo(5)
        }
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(userImage.snp_left)
            make.top.equalTo(userImage.snp_bottom)
            
        }
        
       
 
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
