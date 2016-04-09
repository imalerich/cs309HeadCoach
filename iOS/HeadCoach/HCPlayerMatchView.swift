//
//  HCPlayerMatchView.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/9/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCPlayerMatchView: UIView {

    /// OFFSET parameter to use throughout this view
    let OFFSET = 16

    /// Displays the rank of the user.
    let rank = UILabel()
    /// Name to display for this view.
    let nameLabel = UILabel()
    /// Player score label, this label will be right alligned
    /// but in line with the nameLabel.
    let score = UILabel()

    init() {
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.clipsToBounds = true

        createViews()
        layoutViews()
    }

    internal func setUserAndScore(score: Int, user: HCUser) {
        self.score.text = String(score)
        self.nameLabel.text = user.name

        // pull additional user information from the data provider
        if let league = HCHeadCoachDataProvider.sharedInstance.league {
            HCHeadCoachDataProvider.sharedInstance.getUserStats(user, league: league, completion: { (stats) in
                if stats != nil {
                    self.rank.text = String(stats!.rank)
                }
            })
        }
    }

    internal func createViews() {
        rank.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        rank.textColor = UIColor.whiteColor()
        rank.backgroundColor = UIColor.footballColor(1.0)
        rank.layer.cornerRadius = 20
        rank.textAlignment = .Center
        rank.clipsToBounds = true
        rank.text = ""

        nameLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        nameLabel.textColor = UIColor(white: 0.2, alpha: 1.0)
        nameLabel.text = ""

        score.font = UIFont.systemFontOfSize(18)
        score.textColor = UIColor.blackColor()
        score.textAlignment = .Right
        score.text = ""
    }

    internal func layoutViews() {
        addSubview(rank)
        rank.snp_makeConstraints { (make) in
            make.left.equalTo(snp_left).offset(OFFSET)
            make.centerY.equalTo(snp_centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(rank.snp_right).offset(OFFSET)
            make.right.equalTo(snp_right).offset(-OFFSET)
            make.top.equalTo(snp_top)
            make.bottom.equalTo(snp_bottom)
        }

        addSubview(score)
        score.snp_makeConstraints { (make) in
            make.width.equalTo(40)
            make.right.equalTo(snp_right).offset(-OFFSET)
            make.top.equalTo(snp_top)
            make.bottom.equalTo(snp_bottom)
        }

        // add a small bottom border to this view
        let bottom = UIView()
        bottom.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(bottom)
        bottom.snp_makeConstraints { (make) in
            make.left.equalTo(snp_left)
            make.right.equalTo(snp_right)
            make.bottom.equalTo(snp_bottom)
            make.height.equalTo(1)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
