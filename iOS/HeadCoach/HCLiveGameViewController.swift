//
//  HCLiveGameViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class HCLiveGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    /*
    let view1 = UITableView()
    let view2 = UITableView()
    */
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // change title of window
        self.title = "Live"
        
        // add chat button
        let chatButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "chatMethod")
        navigationItem.rightBarButtonItem = chatButton
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.tableView.registerClass(HCLiveTableViewCell.classForCoder(), forCellReuseIdentifier: "LiveCell")
        
        
        /*
        view1.delegate = self
        view2.delegate = self
        view1.dataSource = self
        view2.dataSource = self
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        
        view1.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self.view)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.5)
        }
        
        view2.snp_makeConstraints { (make) -> Void in
            make.top.right.bottom.equalTo(self.view)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.5)
        }
        
        self.view1.registerClass(HCLiveTableViewCell.classForCoder(), forCellReuseIdentifier: "LiveCell")
        self.view2.registerClass(HCLiveTableViewCell.classForCoder(), forCellReuseIdentifier: "LiveCell")
        */
        
    }
    
    // method for performing live player chat actions
    func chatMethod(){
        print("Chat initialized")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LiveCell", forIndexPath: indexPath) as? HCLiveTableViewCell
        
        // TODO conditional here to determine whether the divider is placed
        // cell?.setDivider(CGRectMake(cell!.frame.width/2, 0, 5, cell!.frame.height))
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
