//
//  HCLiveTableViewCell.swift
//  HeadCoach
//
//  Created by Joseph Young on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class HCLiveTableViewCell: UITableViewCell
{
    
    var lineView = UIView()
    var leftBox = UIView()
    var rightBox = UIView()
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(lineView)
        self.addSubview(leftBox)
        self.addSubview(rightBox)
        self.rightBox.addSubview(rightLabel)
        self.leftBox.addSubview(leftLabel)
        leftLabel.text = "Left"
        rightLabel.text = "Right"
        lineView.backgroundColor = UIColor.blackColor()
        leftBox.backgroundColor = UIColor.whiteColor()
        rightBox.backgroundColor = UIColor.whiteColor()
        self.bringSubviewToFront(lineView)
        
        self.lineView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(1)
            make.top.bottom.equalTo(self)
        }
        
        self.leftBox.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
        }
        
        self.rightBox.snp_makeConstraints { (make) -> Void in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
        }
        
        self.leftLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(leftBox.snp_center)
        }
        
        self.rightLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(rightBox.snp_center)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    func setDivider(dividerFrame: CGRect){
        lineView.frame = dividerFrame
    }
    */
}