//
//  HCLeagueTableViewCell.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit
import ImageLoader

class HCLeagueTableViewCell: UITableViewCell {

    /// UI Offset parameter.
    let OFFSET = 8

    /// Content view for the cell, the rest will be a border around the cell
    let dataView = UIView()

    /// This will be used to display the users profile picture.
    let img = UIImageView()

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

        // just for testing right now, I'll clean it up later
        img.contentMode = .ScaleAspectFill
        img.clipsToBounds = true

        dataView.addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left)
            make.top.equalTo(dataView.snp_top)
            make.bottom.equalTo(dataView.snp_bottom)
            make.width.equalTo(img.snp_height)
        }
    }

    /// Setup this cell for the given user.
    internal func setUser(user: HCUser) {
        if user.img_url.characters.count > 0 {
            img.load(user.img_url)
        }
    }

    // This shit is required.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
