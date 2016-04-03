//
//  HCDraftingViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit

class HCDraftingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var numPlayers = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change title of window
        self.title = "Drafting"
        
        // initialize tableView
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // TODO - register custom cell
    
        self.tableView.registerClass(HCDraftTableViewCell.classForCoder(), forCellReuseIdentifier: "DraftCell")
    }
    
    // one section used, containing all rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPlayers + 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DraftCell", forIndexPath: indexPath) as! HCDraftTableViewCell
        
        if(indexPath.row == 0){
            cell.lineView.snp_remakeConstraints(closure: { (make) in
                make.width.equalTo(0)
            })
        }
        
        if(indexPath.row > 1 && (indexPath.row % 2) == 1){
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.leftBox.backgroundColor = UIColor.lightGrayColor()
            cell.rightBox.backgroundColor = UIColor.lightGrayColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 1){
            return 60
        }
        return 100
    }
    
    
}
