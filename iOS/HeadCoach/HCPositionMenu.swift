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
    
    override init(frame: CGRect){
        // TODO - do I need to change this frame?
        super.init(frame: frame)
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
            make.left.equalTo(snp_left)
            make.centerY.equalTo(snp_centerY)
            make.width.equalTo(snp_width).multipliedBy(0.66)
            make.height.equalTo(snp_height)
            make.right.equalTo(snp_right).multipliedBy(0.66)
        }
        
        addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalTo(label.snp_right)
            make.right.equalTo(snp_right)
            make.width.equalTo(snp_width).multipliedBy(0.33)
            make.height.equalTo(snp_height)
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
