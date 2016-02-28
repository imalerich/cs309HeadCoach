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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.grayColor()
        self.addSubview(lineView)
        lineView.backgroundColor = UIColor.blackColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDivider(dividerFrame: CGRect){
        lineView.frame = dividerFrame
    }
}