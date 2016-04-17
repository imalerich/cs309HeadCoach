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

    let OFFSET = 8
    
    var photo = UIImageView()
    var name = UILabel()
    var player = FDPlayer()

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
        name.text = "Name: "
        name.textAlignment = .Left

        // ONLY display the data from the HCPlayer class,
        // that way we will only ever have to pull one 
        // fantasy data player at a time
        // in this case, I have removed the team label,
        // I have added the photoUrl to the HCPlayer class
        // so we will still have access to that

        photo.load("http://vignette1.wikia.nocookie.net/mario/images/1/15/MarioNSMB2.png/revision/latest?cb=20120816162009")
        photo.layer.cornerRadius = (60 - 16)/2
        photo.layer.borderWidth = 1
        photo.layer.borderColor = UIColor.blackColor().CGColor
        photo.clipsToBounds = true
        photo.contentMode = .ScaleAspectFill
    }
    
    internal func layoutViews(){
        addSubview(photo)
        photo.snp_makeConstraints { (make) in
            // give's the top and bottom coordinate -> height
            // also gives the left coordinate
            make.left.top.equalTo(self).offset(OFFSET)
            make.bottom.equalTo(self).offset(-OFFSET)
            // make the image a square by setting
            // the width to be equal to the height
            // it is okay to reference yourself where
            // it makes sense
            make.height.equalTo(photo.snp_width)
        }
        
        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(photo.snp_right).offset(OFFSET)
            make.right.top.equalTo(self)
            // height and weight are scalars, so we can use
            // divided by, if this were 'right' or 'left' which
            // are only edges of views, 'dividedBy' would not work
            // but 'offset' would still work
            // not 'offset' in terms of scalar is done via addition
            make.height.equalTo(self.snp_height)
        }
    }
    
    func changePlayer(player: HCPlayer){
        name.text = "Name: \(player.name)"
        photo.load(player.img)
    }
}
