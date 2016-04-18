//
//  HCDraftingViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift


class HCDraftingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
 
    let progress = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let tableView = UITableView()
    var numPlayers = 0
    var selection = "TE"
    var players = try! Realm().objects(FDPlayer)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change title of window
        self.title = "Drafting"
        
        if(numPlayers == 0){
            view.addSubview(progress)
            progress.snp_makeConstraints(closure: { (make) in
                make.center.equalTo(self.view)
                progress.startAnimating()
                self.view.bringSubviewToFront(progress)
            })
            
            HCFantasyDataProvider().getPlayerDetails(){(responseString:String?) in
                self.progress.removeFromSuperview()
                self.progress.stopAnimating()
            }
            
            players = try! Realm().objects(FDPlayer).filter("position = '\(selection)'")
            
            numPlayers = players.count
        }
        
        
        
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
            cell.button.hidden = true
            
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
        
        if(indexPath.row > 1){
            cell.leftLabel.text = players[indexPath.row - 2].name
            cell.photo.load(players[indexPath.row - 2].photoURL)
            cell.rightLabel1.text = "Position: " + players[indexPath.row - 2].position
            cell.rightLabel2.text = "Age: \(players[indexPath.row - 2].age)"
            cell.rightLabel3.text = "Height: " + players[indexPath.row - 2].height
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row > 1){
            let vc: UIViewController? = HCUserDetailViewController()
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 1){
            return 60
        }
        return 100
    }
    
    
}
