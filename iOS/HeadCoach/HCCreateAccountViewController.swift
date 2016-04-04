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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(info)
        self.view.addSubview(tableView)
        self.view.addSubview(createButton)
        self.view.addSubview(userName)
        userName.placeholder = "username"
        info.numberOfLines = 0
        info.text = "Enter a unique username and select a league to join"
        createButton.setTitle("Create Account", forState: .Normal)
        createButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        createButton.layer.borderWidth = 2
        createButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
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
        createButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(userName.snp_centerX)
            make.top.equalTo(userName.snp_bottom)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        code
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}
