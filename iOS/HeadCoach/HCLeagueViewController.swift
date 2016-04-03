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
    var list:[HCUser] = []
    let tableView = UITableView()
    let image = UIImageView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.grayColor()
        title = "Elite_Haxors"
        self.view.addSubview(tableView)
        self.tableView.registerClass(HCLeagueTableViewCell.classForCoder(), forCellReuseIdentifier: "LeagueCell")
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
            HCHeadCoachDataProvider.sharedInstance.getAllUsers({ (error, users) in
                print(error)
                print(users.count)
                self.list = users
                self.tableView.reloadData()
            })
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeagueCell", forIndexPath: indexPath) as? HCLeagueTableViewCell
        cell?.userName.text = list[indexPath.row].name
        cell?.separatorInset = UIEdgeInsetsZero
        cell?.layoutMargins = UIEdgeInsetsZero
        cell?.preservesSuperviewLayoutMargins = false
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell!;
            
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("clicked")
        let vc = HCUserDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



