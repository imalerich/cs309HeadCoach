//
//  HCLeagueDetailsHeaderCell.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/11/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCLeagueDetailsHeaderCell: UITableViewHeaderFooterView {

    /// Name detail label for the current league.
    let name = UILabel()

    /// Current week number.
    let week = UILabel()

    /// Number of users currently involved in the league.
    let users = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.footballColor(0.8)

        name.textColor = UIColor.whiteColor()
        name.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        name.adjustsFontSizeToFitWidth = true
        name.textAlignment = .Center

        week.textColor = UIColor.whiteColor()
        week.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        week.adjustsFontSizeToFitWidth = true
        week.backgroundColor = UIColor.footballColor(1.0)
        week.textAlignment = .Center

        users.textColor = UIColor.whiteColor()
        users.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        users.adjustsFontSizeToFitWidth = true
        users.textAlignment = .Center

        contentView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left)
            make.top.equalTo(contentView.snp_top)
            make.bottom.equalTo(contentView.snp_bottom)
            make.width.equalTo(contentView.snp_width).dividedBy(3)
        }

        contentView.addSubview(week)
        week.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right)
            make.top.equalTo(contentView.snp_top)
            make.bottom.equalTo(contentView.snp_bottom)
            make.width.equalTo(contentView.snp_width).dividedBy(3)
        }

        contentView.addSubview(users)
        users.snp_makeConstraints { (make) in
            make.right.equalTo(contentView.snp_right)
            make.top.equalTo(contentView.snp_top)
            make.bottom.equalTo(contentView.snp_bottom)
            make.width.equalTo(contentView.snp_width).dividedBy(3)
        }
    }

    /// Set the date for this cell using the given league.
    internal func setLeague(league: HCLeague) {
        name.text = league.name
        week.text = "Week \(league.week_number)"
        users.text = "\(league.users.count)/5 Users"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
