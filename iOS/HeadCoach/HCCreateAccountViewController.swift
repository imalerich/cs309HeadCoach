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

class HCCreateAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let info = UILabel()
    let tableView = UITableView()
    let createButton = UIButton()
    let userName = UITextField()
    var leagues:[HCLeague] = []

    let back = UIButton()

    var pageController: HCSetupViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(info)
        self.view.addSubview(tableView)
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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "CreateCell")
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None

        info.numberOfLines = 0
        info.text = "Enter a unique username and select a league to join"
        info.textAlignment = .Center
        info.textColor = UIColor.whiteColor()

        createButton.setTitle("Create Account", forState: .Normal)
        createButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        createButton.addTarget(self, action: #selector(self.createAccountAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        createButton.backgroundColor = UIColor.footballColor(1.3)
        createButton.layer.cornerRadius = 25
        createButton.addTouchEvents()

        HCHeadCoachDataProvider.sharedInstance.getAllLeagues { (error, leaguestemp) in
            self.leagues = leaguestemp
            self.tableView.reloadData()
        }

        back.snp_makeConstraints { (make) in
            make.left.equalTo(self.view.snp_left)
            make.top.equalTo(self.view.snp_top).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }

        info.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.lessThanOrEqualTo(80)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        userName.snp_makeConstraints { (make) in
            make.left.equalTo(info.snp_left)
            make.top.equalTo(info.snp_bottom)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
       
        tableView.snp_makeConstraints { (make) in
            make.centerX.equalTo(userName.snp_centerX)
            make.top.equalTo(userName.snp_bottom)
            make.height.equalTo(300)
            make.width.equalTo(200)
        }

        createButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(userName.snp_centerX)
            make.top.equalTo(tableView.snp_bottom)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
    }
    func createAccountAction(sender: UIButton!){
        UIView.animateWithDuration(0.09, animations: {
            self.createButton.transform = CGAffineTransformMakeScale(0.6, 0.6) },
        completion: { finish in
            UIView.animateWithDuration(0.09) {
                self.createButton.transform = CGAffineTransformIdentity }
        })

        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.registerUser(userName.text!) { (error) in
            dp.getUserID(self.userName.text!, completion: { (error, user) in
                // we need a valid row to have a valid league
                let ip = self.tableView.indexPathForSelectedRow
                if ip == nil { return }

                if ip!.row < self.leagues.count {
                    let league = self.leagues[ip!.row]
                    dp.addUserToLeague(user!, league: league, completion: { (error) in })
                }
            })
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CreateCell", forIndexPath: indexPath)
        cell.textLabel?.text = leagues[indexPath.row].name
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func backToLogin(sender:UIButton!){
        pageController?.pagevc.setViewControllers([(pageController?.login)!],
                                           direction: UIPageViewControllerNavigationDirection.Reverse,
                                           animated: true, completion: nil)
    }
    
}
