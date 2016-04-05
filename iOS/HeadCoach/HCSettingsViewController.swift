//
//  HCSettingsViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/5/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCSettingsViewController: UIViewController {

    var logout = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // creates a button the user can use to logout of the application
        logout.setTitle("Logout", forState: .Normal)
        logout.setTitleColor(UIColor.grayColor(), forState: .Normal)
        logout.layer.borderColor = UIColor.lightGrayColor().CGColor
        logout.layer.borderWidth = 2
        logout.showsTouchWhenHighlighted = true

        // add the action events for this button
        logout.addTouchEvents()
        logout.addTarget(HCHeadCoachDataProvider.sharedInstance,
                         action: #selector(HCHeadCoachDataProvider.logoutUser),
                         forControlEvents: UIControlEvents.TouchUpInside)

        // add and layout the button
        self.view.addSubview(logout)
        logout.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

}
