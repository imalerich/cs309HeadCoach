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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(userName)
        self.view.addSubview(createNew)
        self.view.addSubview(login)
        self.view.addSubview(progress)
        userName.placeholder = "username"
        createNew.setTitle("Create a new account", forState: .Normal)
        createNew.setTitleColor(UIColor.grayColor(), forState: .Normal)
        createNew.layer.borderColor = UIColor.lightGrayColor().CGColor
        createNew.layer.borderWidth = 2
        createNew.addTarget(self, action: "newAccount:", forControlEvents: UIControlEvents.TouchUpInside)
        login.setTitle("Login", forState: .Normal)
        login.setTitleColor(UIColor.grayColor(), forState: .Normal)
        login.layer.borderColor = UIColor.lightGrayColor().CGColor
        login.layer.borderWidth = 2
        login.showsTouchWhenHighlighted = true
        login.addTarget(self, action: "loginAction:", forControlEvents: UIControlEvents.TouchUpInside)
        userName.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY).dividedBy(1.3)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        login.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.left.equalTo(userName.snp_left)
        }
        createNew.snp_makeConstraints { (make) in
            make.top.lessThanOrEqualTo(self.login.snp_bottom).offset(50)
            make.centerX.equalTo(userName.snp_centerX)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.left.equalTo(userName.snp_left)
        }
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
        UIView.animateWithDuration(0.09,animations: { self.login.transform = CGAffineTransformMakeScale(0.6, 0.6) },completion: { finish in UIView.animateWithDuration(0.09){ self.login.transform = CGAffineTransformIdentity }})
        HCHeadCoachDataProvider.sharedInstance.getUserID(userName.text!) { (error, user) in
            if(error){
                self.presentViewController(self.alert, animated: true) {
                    () -> Void in
                }
                self.progress.stopAnimating()
            }else{
                self.progress.stopAnimating()
                let preferences = NSUserDefaults.standardUserDefaults()
                
                let currentUser = user?.name
                preferences.setValue(currentUser, forKey: "currentUser")
                //  Save to disk
                let didSave = preferences.synchronize()
                
                if !didSave {
                    //  Couldn't save (I've never seen this happen in real world testing)
                }
                let vc = HCLandingViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    func newAccount(sender:UIButton!){
        createNew = sender as UIButton
        UIView.animateWithDuration(0.09,animations: { self.createNew.transform = CGAffineTransformMakeScale(0.6, 0.6) },completion: { finish in UIView.animateWithDuration(0.09){ self.createNew.transform = CGAffineTransformIdentity }})
    }
}
