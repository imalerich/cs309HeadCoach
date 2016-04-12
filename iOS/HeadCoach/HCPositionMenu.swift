//
//  HCPositionMenu.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/12/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit
import SnapKit

class HCPositionMenu : UIView {
    
    var label = UILabel()
    var button = UIButton()
    var position = Position.All
    let OFFSET = 16
    
    init(){
        super.init(frame: CGRectMake(0,0,0,0))
        self.clipsToBounds = true
        backgroundColor = UIColor.footballColor(1.0)
        
        initViews()
        layoutViews()
    }
    
    internal func initViews(){
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.whiteColor()
        label.text = "Position: \(HCPositionUtil.positionToString(position))"
        label.textAlignment = .Center
        
        button.setTitle("Change", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        // TODO - set button action
    }
    
    internal func layoutViews(){
        addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(snp_left).offset(OFFSET)
            make.centerY.equalTo(snp_centerY)
            make.width.equalTo(snp_width).multipliedBy(0.66)
            make.height.equalTo(snp_height).offset(-OFFSET)
            make.right.equalTo(snp_right).multipliedBy(0.66).offset(-OFFSET)
        }
        
        addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalTo(snp_right).multipliedBy(0.66).offset(OFFSET)
            make.right.equalTo(snp_right).offset(-OFFSET)
            make.width.equalTo(snp_width).dividedBy(3.0)
            make.height.equalTo(snp_height).offset(-OFFSET)
            make.centerY.equalTo(snp_centerY)
        }
    }
    
    
    func changePosition(position : Position){
        self.position = position
        label.text = "Position: \(HCPositionUtil.positionToString(position))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
