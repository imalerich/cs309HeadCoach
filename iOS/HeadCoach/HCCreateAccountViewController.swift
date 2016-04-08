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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(info)
        self.view.addSubview(tableView)
        self.view.addSubview(createButton)
        self.view.addSubview(userName)
        tableView.delegate = self
        tableView.dataSource = self
        userName.placeholder = "username"
        info.numberOfLines = 0
        tableView.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "CreateCell")
        info.text = "Enter a unique username and select a league to join"
        createButton.setTitle("Create Account", forState: .Normal)
        createButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        createButton.layer.borderWidth = 2
        createButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        createButton.addTarget(self, action: "createAccountAction:", forControlEvents: UIControlEvents.TouchUpInside)
        HCHeadCoachDataProvider.sharedInstance.getAllLeagues { (error, leaguestemp) in
                self.leagues = leaguestemp
                self.tableView.reloadData()
            }
        info.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.lessThanOrEqualTo(100)
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
            make.width.equalTo(150)
        }
        
    }
    func createAccountAction(sender: UIButton!){
        UIView.animateWithDuration(0.09,animations: { self.createButton.transform = CGAffineTransformMakeScale(0.6, 0.6) },completion: { finish in UIView.animateWithDuration(0.09){ self.createButton.transform = CGAffineTransformIdentity }})
                HCHeadCoachDataProvider.sharedInstance.registerUser(userName.text!) { (error) in
                HCHeadCoachDataProvider.sharedInstance.getUserID(self.userName.text!, completion: { (error, user) in
                HCHeadCoachDataProvider.sharedInstance.addUserToLeague(user!, league: self.leagues[(self.tableView.indexPathForSelectedRow?.row)!], completion: { (error) in
                        })
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
    
}
