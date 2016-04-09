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
    /// Player0 detail view
    let player0 = HCPlayerMatchView()
    /// Player1 detail view
    let player1 = HCPlayerMatchView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 0.2, alpha: 0.0)

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

        dataView.addSubview(player0)
        player0.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left)
            make.right.equalTo(dataView.snp_right)
            make.top.equalTo(dataView.snp_top)
            make.height.equalTo(dataView.snp_height).dividedBy(2)
        }

        dataView.addSubview(player1)
        player1.snp_makeConstraints { (make) in
            make.left.equalTo(dataView.snp_left)
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
    }

    // this shit is required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
