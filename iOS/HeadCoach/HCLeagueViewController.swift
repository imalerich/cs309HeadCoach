//
//  HCLeagueViewController.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit
import ImageLoader


class HCLeagueViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    let tableView = UITableView()
    let image = UIImageView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.delegate = self
        
        tableView.dataSource = self

        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.grayColor()
        self.view.addSubview(tableView)
        self.tableView.registerClass(HCLeagueTableViewCell.classForCoder(), forCellReuseIdentifier: "LeagueCell")
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        //changes
        HCHeadCoachDataProvider.sharedInstance.createNewUser("Doug") { (error) in
            print(error)
            HCHeadCoachDataProvider.sharedInstance.getAllUsers({ (error, users) in
                print(error)
                print(users.count)
            })
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeagueCell", forIndexPath: indexPath) as? HCLeagueTableViewCell
//        cell?.textLabel?.text = ["Live Game", "Landing View", "Team Management", "Drafting View", "Player Detail", "User Detail", "League View","hurr","durr","adsfasfd"][indexPath.row];
        return cell!;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    
    
}



