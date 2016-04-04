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
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.blackColor()
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        //register custom cell
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
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        if(indexPath.row == 0){
            cell.leftBox.hidden = true
            cell.rightBox.snp_remakeConstraints(closure: { (make) in
                make.edges.equalTo(cell)
            })
            cell.rightLabel2.hidden = true
            cell.rightLabel3.hidden = true
            
            // TODO - Display actual amount of turns until pick
            cell.rightLabel1.text = "Your pick in x turns"
        }
        
        if(indexPath.row == 1){
            cell.rightLabel2.hidden = true
            cell.rightLabel3.hidden = true
            cell.photo.hidden = true
            
            cell.leftLabel.text = "Player"
            cell.rightLabel1.text = "Info"
            
            cell.rightLabel1.snp_remakeConstraints(closure: { (make) in
                make.center.equalTo(cell.rightBox)
            })
            cell.leftLabel.snp_remakeConstraints(closure: { (make) in
                make.height.centerX.equalTo(cell.leftBox)
            })
            
            cell.leftLabel.font = UIFont.boldSystemFontOfSize(20.0)
            cell.rightLabel1.font = UIFont.boldSystemFontOfSize(20.0)
        }
        
        if(indexPath.row > 1 && (indexPath.row % 2) == 1){
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.leftBox.backgroundColor = UIColor.lightGrayColor()
            cell.rightBox.backgroundColor = UIColor.lightGrayColor()
            cell.leftLabel.textAlignment = .Center
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
