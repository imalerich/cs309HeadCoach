//
//  HCLoginScreenViewController.swift
//  HeadCoach
//
//  Created by Johnson, Mitchell D [ITADM] on 4/3/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import SnapKit
import RealmSwift

class HCLoginScreenViewController: UIViewController{
    
    let userName = UITextField()
    var createNew = UIButton()
    var login = UIButton()
    var userString = ""
    let progress = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let alert = UIAlertController(title:"Incorrect Username",message:"Please enter a valid username or create a new account",preferredStyle:UIAlertControllerStyle.Alert)
    let alertAction = UIAlertAction(title: "Okay",style: UIAlertActionStyle.Default){
        (UIAlertAction) -> Void in
    }

    let titleView = UITextView()
    var pageController: HCSetupViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()

        userName.placeholder = "username"
        userName.textColor = UIColor.whiteColor()
        userName.layer.borderColor = UIColor(white: 1.0, alpha: 0.4).CGColor
        userName.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        userName.textAlignment = .Center
        userName.layer.cornerRadius = 25
        userName.layer.borderWidth = 1
        userName.clipsToBounds = true

        createNew.setTitle("Register", forState: .Normal)
        createNew.setTitleColor(UIColor.footballColor(1.3), forState: .Normal)
        createNew.titleLabel!.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        createNew.layer.cornerRadius = 25
        createNew.backgroundColor = UIColor.whiteColor()
        createNew.addTouchEvents()
        createNew.addTarget(self, action: #selector(self.newAccount(_:)),
                            forControlEvents: UIControlEvents.TouchUpInside)

        login.setTitle("Login", forState: .Normal)
        login.titleLabel!.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        login.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        login.layer.cornerRadius = 25
        login.backgroundColor = UIColor.footballColor(1.3)
        login.addTouchEvents()
        login.addTarget(self, action: #selector(self.loginAction(_:)),
                        forControlEvents: UIControlEvents.TouchUpInside)

        titleView.text = "Head Coach"
        titleView.textColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.clearColor()
        titleView.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
        titleView.textAlignment = .Center

        self.view.addSubview(login)
        login.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp_centerY)
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerX.equalTo(self.view.snp_centerX)
        }

        self.view.addSubview(userName)
        userName.snp_makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(login.snp_top).offset(-8)
            make.left.equalTo(login.snp_left)
            make.right.equalTo(login.snp_right)
        }

        self.view.addSubview(createNew)
        createNew.snp_makeConstraints { (make) in
            make.top.lessThanOrEqualTo(self.login.snp_bottom).offset(32)
            make.left.equalTo(userName.snp_left)
            make.right.equalTo(userName.snp_right)
            make.height.equalTo(50)
        }

        view.addSubview(titleView)
        titleView.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(50)
            make.bottom.equalTo(userName.snp_top).offset(-32)
        }

        self.view.addSubview(progress)
        progress.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalTo(userName.snp_right)
            make.bottom.equalTo(userName.snp_bottom)
        }

        self.alert.addAction(self.alertAction)
    }

    func loginAction(sender:UIButton!){
        progress.startAnimating()
        login = sender as UIButton

        HCHeadCoachDataProvider.sharedInstance.getUserID(userName.text!) { (error, user) in
            if(error){
                self.presentViewController(self.alert, animated: true) { () -> Void in }
                self.progress.stopAnimating()
            } else {
                HCHeadCoachDataProvider.sharedInstance.user = user!

                HCHeadCoachDataProvider.sharedInstance.getAllLeaguesForUser(user!, completion: { (err, leagues) in
                    if leagues.count > 0 {
                        HCHeadCoachDataProvider.sharedInstance.league = leagues[0]
                    }

                    self.pageController?.dismissViewControllerAnimated(true, completion: nil)
                    self.progress.stopAnimating()
                })
            }
        }
    }
    
    func newAccount(sender:UIButton!){
        pageController?.pagevc.setViewControllers([(pageController?.newAccount)!],
                                           direction: UIPageViewControllerNavigationDirection.Forward,
                                           animated: true, completion: nil)
    }
}
