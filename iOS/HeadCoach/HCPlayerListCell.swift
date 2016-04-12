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
    
    var photo = UIImageView()
    var name = UILabel()
    var team = UILabel()
    var player = FDPlayer()
    let OFFSET = 16
    
    
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
        name.font = UIFont.systemFontOfSize(12.0)
        team.font = UIFont.systemFontOfSize(12.0)
        
        name.text = "Name: "
        team.text = "Team: "
        
        name.textAlignment = .Left
        team.textAlignment = .Left
        
        photo.load("http://electrodvigatel31.ru/image/no-foto.jpeg")
        photo.layer.cornerRadius = 30
        photo.layer.borderWidth = 2
        photo.layer.masksToBounds = false
        photo.clipsToBounds = true
        photo.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    internal func layoutViews(){
        addSubview(photo)
        photo.snp_makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self.snp_height)
            make.size.equalTo(CGSizeMake(30, 30))
        }
        
        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.top.equalTo(self)
            make.bottom.equalTo(snp_height).dividedBy(2.0)
            make.width.equalTo(snp_width).multipliedBy(0.66)
            make.height.equalTo(snp_height).dividedBy(2.0)
        }
        
        addSubview(team)
        team.snp_makeConstraints { (make) in
            make.left.right.width.height.equalTo(name)
            make.bottom.equalTo(self)
            make.top.equalTo(name.snp_bottom)
            
        }
    }
    
    func changePlayer(player: HCPlayer){
        self.player = try! Realm().objects(FDPlayer).filter("id == \(player.fantasy_id)").first!
        
        name.text = "Name: \(player.name)"
        team.text = "Team: \(self.player.team)"
        photo.load(self.player.photoURL)
    }
}
