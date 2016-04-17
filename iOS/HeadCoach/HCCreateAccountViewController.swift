//
//  HCCreateAccountViewController.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 4/3/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import SnapKit
import RealmSwift
import Alamofire

class HCCreateAccountViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    let info = UILabel()
    let createButton = UIButton()
    let userName = UITextField()
    let back = UIButton()

    var pageController: HCSetupViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(info)
        self.view.addSubview(createButton)
        self.view.addSubview(userName)
        self.view.addSubview(back)

        back.setTitle("Back", forState: .Normal)
        back.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        back.addTarget(self, action: #selector(self.backToLogin(_:)), forControlEvents: .TouchUpInside)

        userName.placeholder = "username"
        userName.textColor = UIColor.whiteColor()
        userName.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        userName.layer.borderColor = UIColor(white: 1.0, alpha: 0.4).CGColor
        userName.textAlignment = .Center
        userName.layer.cornerRadius = 25
        userName.layer.borderWidth = 1
        userName.clipsToBounds = true

        info.numberOfLines = 0
        info.text = "Enter your desired Head Coach account name."
        info.textAlignment = .Center
        info.textColor = UIColor.whiteColor()

        createButton.setTitle("Create Account", forState: .Normal)
        createButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        createButton.addTarget(self, action: #selector(self.createAccountAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        createButton.backgroundColor = UIColor.footballColor(1.3)
        createButton.layer.cornerRadius = 25
        createButton.addTouchEvents()

        back.snp_makeConstraints { (make) in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(self.view.snp_top).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }

        userName.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        info.snp_makeConstraints { (make) in
            make.bottom.equalTo(userName.snp_top).offset(-32)
            make.height.equalTo(50)
            make.left.equalTo(userName.snp_left)
            make.right.equalTo(userName.snp_right)
        }

        createButton.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom).offset(32)
            make.height.equalTo(50)
            make.left.equalTo(userName.snp_left)
            make.right.equalTo(userName.snp_right)
        }

    }
    func createAccountAction(sender: UIButton!){
        if userName.text?.characters.count == 0 {
            let alert = UIAlertController(title: "Error",
                                          message: "Please enter a desired username",
                                          preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)

            return
        }

        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.registerUser(userName.text!) { (error) in
            if error {
                let alert = UIAlertController(title: "Error",
                                              message: "Account name already exists.",
                                              preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)

                return
            }

            dp.getUserID(self.userName.text!, completion: { (error, user) in
                dp.user = user
                self.pageController?.pagevc.setViewControllers([(self.pageController?.joinLeague)!],
                    direction: UIPageViewControllerNavigationDirection.Forward,
                    animated: true, completion: nil)
            })
        }
    }

    /// Pushes the original login view controller as the active view
    /// in the UIPageViewController responsible for managing login.
    func backToLogin(sender:UIButton!){
        pageController?.pagevc.setViewControllers([(pageController?.login)!],
                                           direction: UIPageViewControllerNavigationDirection.Reverse,
                                           animated: true, completion: nil)
    }

    
}
