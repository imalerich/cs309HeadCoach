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

        wins.textAlignment = .Center
        loses.textAlignment = .Center
        draws.textAlignment = .Center

        wins.textColor = UIColor(white: 0.4, alpha: 1.0)
        loses.textColor = UIColor(white: 0.4, alpha: 1.0)
        draws.textColor = UIColor(white: 0.4, alpha: 1.0)

        wins.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        loses.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        draws.backgroundColor = UIColor(white: 0.98, alpha: 1.0)

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

        // Add a little border on the left edge of the view.
        let left = UIView()
        left.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        addSubview(left)
        left.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(1)
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

    /// Content view for the cell, the rest will be a border around the cell.
    let dataView = UIView()

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
            make.left.equalTo(dataView.snp_left).offset(OFFSET)
            make.top.equalTo(dataView.snp_top).offset(OFFSET)
            make.bottom.equalTo(dataView.snp_bottom).offset(-OFFSET)
            make.width.equalTo(img.snp_height)
        }

        dataView.addSubview(details)
        details.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(dataView)
            make.width.equalTo(120)
        }

        dataView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(OFFSET)
            make.right.equalTo(details.snp_left)
            make.top.equalTo(dataView).offset(1.5 * Double(OFFSET))
            make.height.equalTo(dataView.snp_height).dividedBy(2)
        }

        dataView.addSubview(rank)
        rank.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(OFFSET)
            make.right.equalTo(details.snp_left)
            make.bottom.equalTo(dataView).offset(1.5 * Double(-OFFSET))
            make.height.equalTo(dataView.snp_height).dividedBy(2)
        }
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
