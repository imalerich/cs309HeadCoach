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

class HCUserStandingView: UIView {
    /// Label describing the number of wins the player has.
    let wins = UILabel()

    /// Label describing the number of loses the player has.
    let loses = UILabel()

    /// Label describing the number of draws the player has.
    let draws = UILabel()

    init() {
        super.init(frame: CGRectZero)

//        wins.textAlignment = .Center
//        loses.textAlignment = .Center
//        draws.textAlignment = .Center

        wins.textColor = UIColor(white: 0.4, alpha: 1.0)
        loses.textColor = UIColor(white: 0.4, alpha: 1.0)
        draws.textColor = UIColor(white: 0.4, alpha: 1.0)

        wins.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        loses.font = wins.font
        draws.font = wins.font

        // Layout all of the subviews.
        addSubview(wins)
        wins.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(self.snp_height).dividedBy(3)
            make.top.equalTo(self)
        }

        addSubview(loses)
        loses.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(self.snp_height).dividedBy(3)
            make.centerY.equalTo(self)
        }

        addSubview(draws)
        draws.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(self.snp_height).dividedBy(3)
            make.bottom.equalTo(self)
        }
    }

    /// Update these labels with the an HCUSerStats object.
    internal func setStats(stats: HCUserStats) {
        wins.text = "\(stats.wins) Wins"
        loses.text = "\(stats.loses) Loses"
        draws.text = "\(stats.draws) Draws"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HCLeagueTableViewCell: UITableViewCell {

    /// UI Offset parameter.
    let OFFSET = 8

    /// This will be used to display the users profile picture.
    let img = UIImageView()

    /// This label will be top aligned and contain the user name for each user.
    let name = UILabel()

    /// The current rank for this user, where 'Rank 1' indicates the user is
    /// currently the highest ranked in this league.
    let rank = UILabel()

    /// This view will display the users current wins/loses/draws.
    let details = HCUserStandingView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()

        name.textColor = UIColor.blackColor()
        rank.textColor = UIColor(white: 0.4, alpha: 1.0)

        name.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        rank.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)

        // just for testing right now, I'll clean it up later
        img.contentMode = .ScaleAspectFill
        img.clipsToBounds = true
        img.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).CGColor
        img.layer.borderWidth = 1

        addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(OFFSET)
            make.top.equalTo(self.snp_top).offset(3 * OFFSET)
            make.bottom.equalTo(self.snp_bottom).offset(3 * -OFFSET)
            make.width.equalTo(img.snp_height)
        }

        addSubview(details)
        details.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(100)
        }

        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(2 * OFFSET)
            make.right.equalTo(details.snp_left)
            make.top.equalTo(self).offset(1.5 * Double(OFFSET))
            make.height.equalTo(self.snp_height).dividedBy(2)
        }

        addSubview(rank)
        rank.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.right.equalTo(details.snp_left)
            make.bottom.equalTo(self).offset(1.5 * Double(-OFFSET))
            make.height.equalTo(self.snp_height).dividedBy(2)
        }

        // add a small border to the bottom of the cell
        let bottom = UIView()
        bottom.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(bottom)
        bottom.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }

        // add a top border, this will overlap the bottom border
        // of the cell above this one, but will be visible on the first cell
        let top = UIView()
        top.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(top)
        top.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp_top)
            make.height.equalTo(1)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        img.layer.cornerRadius = img.frame.size.height / 2
    }

    /// Setup this cell for the given user.
    internal func setUser(user: HCUser) {
        if user.img_url.characters.count > 0 {
            img.load(user.img_url)
        }

        name.text = user.name

        if user.stats == nil {
            // load the data
            let league = HCHeadCoachDataProvider.sharedInstance.league
            HCHeadCoachDataProvider.sharedInstance.getUserStats(user, league: league!, completion: { (stats) in
                if stats != nil {
                    self.details.setStats(user.stats!)
                    self.rank.text = "Rank \(user.stats!.rank)"
                }
            })
        } else {
            // data is already loaded
            details.setStats(user.stats!)
            rank.text = "Rank \(user.stats!.rank)"
        }
    }

    // This shit is required.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
