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

    /// Containing view for the Week label, we are keeping it as a property so
    /// we can change the background color for games that are finished
    /// vs games that have yet to be played.
    let weekContainer = UIView()

    /// The week the game took place.
    let week = UILabel()

    /// Player0 detail view
    let player0 = HCPlayerMatchView()

    /// Player1 detail view
    let player1 = HCPlayerMatchView()
    
    var delegate: UIViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()

        dataView.backgroundColor = UIColor.whiteColor()
        dataView.layer.cornerRadius = 2
        dataView.clipsToBounds = true

        week.backgroundColor = UIColor.clearColor()
        week.textColor = UIColor(white: 0.3, alpha: 1.0)
        week.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        week.textAlignment = .Center

        addSubview(dataView)
        dataView.snp_makeConstraints(closure: { make in
            make.left.equalTo(self.snp_left).offset(OFFSET)
            make.right.equalTo(self.snp_right).offset(-OFFSET)
            make.top.equalTo(self.snp_top).offset(OFFSET)
            make.bottom.equalTo(self.snp_bottom)
        })

        weekContainer.backgroundColor = UIColor(white: 0.86, alpha: 1.0)
        dataView.addSubview(weekContainer)
        weekContainer.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left).offset(-36)
            make.width.equalTo(dataView.snp_height)
            make.centerY.equalTo(dataView.snp_centerY)
            make.height.equalTo(40)
        }

        // add a small bottom border to this view
        let right = UIView()
        right.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        weekContainer.addSubview(right)
        right.snp_makeConstraints { (make) in
            make.right.equalTo(weekContainer.snp_right)
            make.top.equalTo(weekContainer.snp_top)
            make.bottom.equalTo(weekContainer.snp_bottom)
            make.width.equalTo(1)
        }

        weekContainer.addSubview(week)
        week.snp_makeConstraints { (make) in
            make.edges.equalTo(weekContainer)
        }

        weekContainer.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI/2))

        dataView.addSubview(player0)
        player0.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left).offset(40)
            make.right.equalTo(dataView.snp_right)
            make.top.equalTo(dataView.snp_top)
            make.height.equalTo(dataView.snp_height).dividedBy(2)
        }

        dataView.addSubview(player1)
        player1.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left).offset(40)
            make.right.equalTo(dataView.snp_right)
            make.bottom.equalTo(dataView.snp_bottom)
            make.height.equalTo(dataView.snp_height).dividedBy(2)
        }
    }

    /// Set up this view with data retrieved from an
    /// HCGameResult object.
    internal func setGame(game: HCGameResult) {
        player0.setUserAndScore(game.scores.0, user: game.users.0)
        player1.setUserAndScore(game.scores.1, user: game.users.1)

        player0.setWinner(game.scores.0 > game.scores.1)
        player1.setWinner(game.scores.1 > game.scores.0)

        week.text = "Week \(game.week)"

        if game.completed {
            weekContainer.backgroundColor = UIColor(white: 0.70, alpha: 1.0)
            week.textColor = UIColor(white: 0.3, alpha: 1.0)
            player0.score.hidden = false
            player1.score.hidden = false
        } else {
            weekContainer.backgroundColor = UIColor(white: 0.86, alpha: 1.0)
            week.textColor = UIColor(white: 0.3, alpha: 1.0)
            player0.score.hidden = true
            player1.score.hidden = true
        }
    }

    // this shit is required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
