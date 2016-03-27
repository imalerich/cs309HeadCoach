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
    var lineView = UIView()
    var leftBox = UIView()
    var rightBox = UIView()
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        lineView.backgroundColor = UIColor.grayColor()
        self.addSubview(leftBox)
        self.addSubview(rightBox)
        self.addSubview(lineView)
        
      //  self.bringSubviewToFront(lineView)
        self.rightBox.addSubview(rightLabel)
        self.leftBox.addSubview(leftLabel)
        leftBox.backgroundColor = UIColor.whiteColor()
        rightBox.backgroundColor = UIColor.whiteColor()
        self.leftBox.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
        }
        self.rightBox.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_centerX)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
        }
        self.rightLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(rightBox.snp_center)
            
        }
        self.leftLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(leftBox.snp_center)
        }
        self.lineView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            make.width.equalTo(1)
        }
        leftLabel.text = "left"
        rightLabel.text = "right"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
