//
//  HCPlayerListCell.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/12/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import SnapKit
import RealmSwift

class HCPlayerListCell : UITableViewCell {

    let OFFSET = 6

    /// Photo for this player.
    let photo = UIImageView()

    /// Name label for this player.
    let name = UILabel()

    /// Details label, this will look like a button, but not actually do anything
    /// selecting any part of the cell will actually perform the action.
    let details = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        initViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initViews(){
        name.text = "Name"
        name.textAlignment = .Left
        name.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)

        details.text = "Details"
        details.textAlignment = .Center
        details.textColor = UIColor(white: 0.4, alpha: 1.0)
        details.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        details.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        details.clipsToBounds = true

        // ONLY display the data from the HCPlayer class,
        // that way we will only ever have to pull one 
        // fantasy data player at a time
        // in this case, I have removed the team label,
        // I have added the photoUrl to the HCPlayer class
        // so we will still have access to that

        photo.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        photo.contentMode = .ScaleAspectFill
        photo.clipsToBounds = true
    }
    
    internal func layoutViews(){
        addSubview(photo)
        photo.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.height.equalTo(photo.snp_width)
        }

        // add a little right border next to the photo
        let right = UIView()
        right.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(right)
        right.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(photo)
            make.right.equalTo(photo.snp_right)
            make.width.equalTo(1)
        }

        addSubview(details)
        details.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(OFFSET)
            make.right.bottom.equalTo(self.contentView).offset(-OFFSET)
            make.width.equalTo(80)
        }

        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(photo.snp_right).offset(2 * OFFSET)
            make.top.equalTo(self)
            make.right.equalTo(details.snp_left).offset(-OFFSET)
            make.height.equalTo(self.snp_height)
        }

        // add a little bottom border
        let bottom = UIView()
        bottom.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(bottom)
        bottom.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(0.8)
        }
    }
    
    func changePlayer(player: HCPlayer){
        name.text = player.name
        photo.load(player.img)
    }
}
