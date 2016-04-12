//
//  HCLeagueTableViewCell.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class HCLeagueTableViewCell: UITableViewCell {

    /// UI Offset parameter.
    let OFFSET = 8

    /// Content view for the cell, the rest will be a border around the cell
    let dataView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()

        dataView.backgroundColor = UIColor.whiteColor()
        dataView.layer.cornerRadius = 2
        dataView.clipsToBounds = true
        addSubview(dataView)
        dataView.snp_makeConstraints(closure: { make in
            make.left.equalTo(self.snp_left).offset(OFFSET)
            make.right.equalTo(self.snp_right).offset(-OFFSET)
            make.top.equalTo(self.snp_top).offset(OFFSET)
            make.bottom.equalTo(self.snp_bottom)
        })
    }

    /// Setup this cell for the given user.
    internal func setUser(user: HCUser) {
        //
    }

    // This shit is required.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
