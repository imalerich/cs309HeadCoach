//
//  HCDraftTableViewCell.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/2/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import SnapKit

class HCDraftTableViewCell : UITableViewCell{
    
    // var lineView = UIView()
    var leftBox = UIView()
    var rightBox = UIView()
    
    var leftLabel = UILabel()
    var rightLabel1 = UILabel()
    var rightLabel2 = UILabel()
    var rightLabel3 = UILabel()
  
    var info1 = "Info1"
    var info2 = "Info2"
    var info3 = "Info3"
    
    var photo = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        self.rightBox.addSubview(rightLabel1)
        self.rightBox.addSubview(rightLabel2)
        self.rightBox.addSubview(rightLabel3)
        self.leftBox.addSubview(leftLabel)
        
        leftLabel.text = "Left"
        rightLabel1.text = "\(info1)"
        rightLabel2.text = "\(info2)"
        rightLabel3.text = "\(info3)"
        leftLabel.font = UIFont.systemFontOfSize(16.0)
        rightLabel1.font = UIFont.systemFontOfSize(16.0)
        rightLabel2.font = UIFont.systemFontOfSize(16.0)
        rightLabel3.font = UIFont.systemFontOfSize(16.0)
        leftLabel.textAlignment = .Center
        rightLabel1.textAlignment = .Center
        rightLabel2.textAlignment = .Center
        rightLabel3.textAlignment = .Center
        
        // lineView.backgroundColor = UIColor.blackColor()
        leftBox.backgroundColor = UIColor.whiteColor()
        rightBox.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(leftBox)
        self.addSubview(rightBox)
        // self.addSubview(lineView)
        
        /*
        self.lineView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(1)
            make.top.bottom.equalTo(self)
        }
        */
        
        self.leftBox.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
        }
        
        self.rightBox.snp_makeConstraints { (make) -> Void in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
        }
        
        self.leftLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.leftBox)
        }
        
        self.rightLabel1.snp_makeConstraints { (make) -> Void in
            make.top.centerX.equalTo(self.rightBox)
            make.height.equalTo(self.rightBox).dividedBy(3.0)
        }
        
        self.rightLabel2.snp_makeConstraints { (make) in
            make.center.equalTo(self.rightBox)
            make.height.equalTo(self.rightBox).dividedBy(3.0)
        }
        
        self.rightLabel3.snp_makeConstraints { (make) in
            make.bottom.centerX.equalTo(self.rightBox)
            make.height.equalTo(self.rightBox).dividedBy(3.0)
        }
    }
    
    
    
    override func prepareForReuse(){
        leftLabel.font = UIFont.systemFontOfSize(16.0)
        rightLabel1.font = UIFont.systemFontOfSize(16.0)
        rightLabel2.font = UIFont.systemFontOfSize(16.0)
        rightLabel3.font = UIFont.systemFontOfSize(16.0)
        
        leftBox.hidden = false
        rightLabel2.hidden = false
        rightLabel3.hidden = false
        rightLabel1.text = "\(info1)"
        rightBox.snp_remakeConstraints { (make) in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
        }
        
        leftBox.backgroundColor = UIColor.whiteColor()
        rightBox.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}