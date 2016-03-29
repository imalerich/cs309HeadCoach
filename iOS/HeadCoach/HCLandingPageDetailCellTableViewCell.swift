//
//  HCLandingPageDetailCellTableViewCell.swift
//  HeadCoach
//
//  Created by Ian Malerich on 3/29/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCLandingPageDetailCellTableViewCell: UITableViewCell {

    /// UI Offset parameter.
    let OFFSET = 8

    /// Content view for the cell, the rest will be a border around the cell
    let dataView = UIView()

    /// Detail text label for this notification.
    let details = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 0.0, alpha: 0.0)

        addSubview(dataView)
        dataView.backgroundColor = UIColor.whiteColor()

        dataView.snp_makeConstraints(closure: { make in
            make.left.equalTo(self.snp_left).offset(OFFSET)
            make.right.equalTo(self.snp_right).offset(-OFFSET)
            make.top.equalTo(self.snp_top).offset(OFFSET)
            make.bottom.equalTo(self.snp_bottom)
        })

        dataView.addSubview(details)
        details.snp_makeConstraints(closure: { make in
            make.left.equalTo(dataView.snp_left).offset(OFFSET)
            make.right.equalTo(dataView.snp_right).offset(-OFFSET)
            make.top.equalTo(dataView.snp_top).offset(OFFSET)
            make.bottom.equalTo(dataView.snp_bottom).offset(-OFFSET)
        })
    }

    // this shit is required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
