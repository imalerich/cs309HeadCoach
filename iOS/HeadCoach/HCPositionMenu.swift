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
    let OFFSET = 8
    var selector = UIPickerView()
    
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
        label.textAlignment = .Left
        
        button.setTitle("Change", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        // TODO - set button action
        button.addTarget(self, action: "changePosition", forControlEvents: .TouchUpInside)
    }
    
    internal func layoutViews(){
        addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(snp_left).offset(OFFSET)
            make.width.equalTo(snp_width).multipliedBy(2/3.0)
        }
        
        addSubview(button)
        button.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(snp_right).offset(-OFFSET)
            make.width.equalTo(snp_width).multipliedBy(1/3.0)
        }
    }
    
    func setMenuSelector(inout selector: UIPickerView){
        self.selector = selector
    }
    
    func changePosition(){
        selector.hidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
