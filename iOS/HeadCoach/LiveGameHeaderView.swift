//
//  LiveGameHeaderView.swift
//  HeadCoach
//
//  Created by Davor Civsa on 4/24/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ActionSheetPicker_3_0

class LiveGameHeaderView: UIView {
    
    var u1Won = true
    let header = UIView()
    let winnerBGColor = UIColor.footballColor(1)
    let loserBGColor = UIColor.whiteColor()
    let u1Image = UIImageView()
    let u2Image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init (game: HCGameResult) {
        self.init(frame : CGRectZero)
        u1Won = game.scores.0 > game.scores.1
        setUpViews(game)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func setUpViews(game: HCGameResult){
        let OFFSET = CGFloat(12)
        let HEADER_HEIGHT = CGFloat(100)
        let PTS_HEIGHT = CGFloat(25)
        
        backgroundColor = u1Won ? loserBGColor : winnerBGColor
        addSubview(header)
        header.snp_makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(HEADER_HEIGHT)
            make.top.equalTo(self)
        }
        
        addSubview(u1Image)
        u1Image.load(game.users.0.img_url)
        u1Image.layer.cornerRadius = (HEADER_HEIGHT - 2 * OFFSET) / 2.0
        u1Image.layer.borderColor = u1Won ? loserBGColor.colorWithAlphaComponent(0.8).CGColor : winnerBGColor.colorWithAlphaComponent(0.8).CGColor
        u1Image.layer.borderWidth = 1
        u1Image.contentMode = .ScaleAspectFill
        u1Image.clipsToBounds = true
        u1Image.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(OFFSET)
            make.left.equalTo(self.snp_left).inset(OFFSET)
            make.height.equalTo(HEADER_HEIGHT - 2 * OFFSET)
            make.width.equalTo(HEADER_HEIGHT - 2 * OFFSET)
        }
        
        addSubview(u2Image)
        u2Image.load(game.users.1.img_url)
        u2Image.layer.cornerRadius = (HEADER_HEIGHT - 2 * OFFSET) / 2.0
        u2Image.layer.borderColor = !u1Won ? loserBGColor.colorWithAlphaComponent(0.8).CGColor : winnerBGColor.colorWithAlphaComponent(0.8).CGColor
        u2Image.layer.borderWidth = 1
        u2Image.contentMode = .ScaleAspectFill
        u2Image.clipsToBounds = true
        u2Image.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(OFFSET)
            make.right.equalTo(self.snp_right).inset(OFFSET)
            make.height.equalTo(HEADER_HEIGHT - 2 * OFFSET)
            make.width.equalTo(HEADER_HEIGHT - 2 * OFFSET)
        }
        
        let divider = UIView()
        addSubview(divider)
        divider.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(1)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
        let u1Name = UILabel()
        addSubview(u1Name)
        u1Name.font = UIFont.systemFontOfSize(20)
        u1Name.text = game.users.0.name
        u1Name.textColor = u1Won ? loserBGColor : winnerBGColor
        u1Name.sizeToFit()
        u1Name.snp_makeConstraints { (make) in
            make.left.equalTo(u1Image.snp_right).offset(OFFSET / 2)
            make.top.equalTo(header).offset(OFFSET)
        }
        
        let u2Name = UILabel()
        addSubview(u2Name)
        u2Name.font = UIFont.systemFontOfSize(20)
        u2Name.text = game.users.1.name
        u2Name.textColor = !u1Won ? loserBGColor : winnerBGColor
        u2Name.sizeToFit()
        u2Name.snp_makeConstraints { (make) in
            make.right.equalTo(u2Image.snp_left).offset(-OFFSET / 2)
            make.bottom.equalTo(header).offset(-OFFSET)
        }
        
        let vsTextBg = UIView()
        addSubview(vsTextBg)
        vsTextBg.backgroundColor = UIColor.whiteColor()
        vsTextBg.layer.cornerRadius = 5
        vsTextBg.layer.masksToBounds = true
        
        let vsText = UILabel()
        addSubview(vsText)
        vsText.font = UIFont.systemFontOfSize(18)
        vsText.text = "vs"
        vsText.textColor = winnerBGColor
        vsText.sizeToFit()
        vsText.snp_makeConstraints { (make) in
            make.center.equalTo(header)
        }
        
        vsTextBg.snp_makeConstraints { (make) in
            make.top.equalTo(vsText).offset(-2)
            make.bottom.equalTo(vsText).offset(2)
            make.right.equalTo(vsText).offset(2)
            make.left.equalTo(vsText).offset(-2)
            make.center.equalTo(vsText)
        }
        
        //background for points display
        let ptsBar = UIView()
        addSubview(ptsBar)
        ptsBar.backgroundColor = UIColor.footballColor(1)
        
        let ptsLabel = UILabel()
        addSubview(ptsLabel)
        ptsLabel.font = UIFont.systemFontOfSize(20)
        ptsLabel.text = "Points"
        ptsLabel.textAlignment = .Center
        ptsLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        ptsLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        let u1Pts = UILabel()
        addSubview(u1Pts)
        u1Pts.font = UIFont.systemFontOfSize(20)
        u1Pts.text = "\(game.scores.0)"
        u1Pts.textAlignment = .Center
        u1Pts.textColor = !u1Won ? UIColor.whiteColor() : UIColor.footballColor(1)
        u1Pts.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        let u2Pts = UILabel()
        addSubview(u2Pts)
        u2Pts.font = UIFont.systemFontOfSize(20)
        u2Pts.text = "\(game.scores.1)"
        u2Pts.textAlignment = .Center
        u2Pts.textColor = u1Won ? UIColor.whiteColor() : UIColor.footballColor(1)
        u2Pts.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
//        let win = UIImageView()
//        addSubview(win)
//        win.image = UIImage(named: "win")
//        win.contentMode = .ScaleAspectFill
//        
        
        ptsBar.snp_makeConstraints { (make) in
            make.top.equalTo(header.snp_bottom)
            make.height.equalTo(PTS_HEIGHT)
            make.width.equalTo(self)
        }
        
        u1Pts.snp_makeConstraints { (make) in
            make.height.equalTo(ptsBar)
            make.width.equalTo(ptsBar).dividedBy(3)
            make.left.equalTo(ptsBar)
            make.top.equalTo(ptsBar)
        }
        
        ptsLabel.snp_makeConstraints { (make) in
            make.height.equalTo(u1Pts)
            make.width.equalTo(u1Pts)
            make.top.equalTo(u1Pts)
            make.left.equalTo(u1Pts.snp_right)
        }
        
        u2Pts.snp_makeConstraints { (make) in
            make.height.equalTo(u1Pts)
            make.width.equalTo(u1Pts)
            make.top.equalTo(u1Pts)
            make.left.equalTo(ptsLabel.snp_right)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //add user 1 background shape
        let u1bgLayer = CAShapeLayer()
        let diag = UIBezierPath()
        diag.moveToPoint(CGPointMake(0, 0))
        diag.addLineToPoint(CGPointMake(0, header.frame.height))
        diag.addLineToPoint(CGPointMake(header.frame.width * (1/3), header.frame.height))
        diag.addLineToPoint(CGPointMake(header.frame.width * (2/3), 0))
        diag.closePath()
        u1bgLayer.path = diag.CGPath
        u1bgLayer.fillColor = u1Won ? UIColor.footballColor(0.8).CGColor : loserBGColor.CGColor
        u1bgLayer.strokeColor = nil
        header.layer.addSublayer(u1bgLayer)
    }

}