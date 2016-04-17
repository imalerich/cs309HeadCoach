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

    let sectionHeaders : [String] = ["Current Scores", "Quarterback", "Wide Reciever 1", "Wide Reciever 2",
        "Wide Reciever 3", "Runningback 1", "Runningback 2", "Tight End", "Kicker", "Defense / Special Teams"]
    var p1Scores : [Int] = [2, 5, 0, 3, 8, 1, 0, 3, 2]
    var p2Scores : [Int] = [0, 1, 3, 5, 5, 4, 1, 9, 2]
    
    
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
        
        
        
    }
    
    // method for performing live player chat actions
    func chatMethod(){
        print(HCRandomInsultGenerator.sharedInstance.generateInsult())
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LiveCell", forIndexPath: indexPath) as! HCLiveTableViewCell
                
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell.leftLabel.text = "YOU"
                cell.leftLabel.font = UIFont.boldSystemFontOfSize(24.0)
                cell.rightLabel.text = "THEM"
                cell.rightLabel.font = UIFont.boldSystemFontOfSize(24.0)
            }
            else{
                let p1Total = p1Scores.reduce(0, combine: +)
                let p2Total = p2Scores.reduce(0, combine: +)
                cell.leftLabel.text = "+\(p1Total)"
                cell.rightLabel.text = "+\(p2Total)"
                if(p1Total != p2Total){
                    cell.leftBox.backgroundColor = UIColor.redColor()
                    cell.rightBox.backgroundColor = UIColor.redColor()
                    if(p1Total > p2Total){
                        cell.leftBox.backgroundColor = UIColor.greenColor()
                    }
                    else{
                        cell.rightBox.backgroundColor = UIColor.greenColor()
                    }
                }
            }
        }
        else{
            cell.leftLabel.text = "+\(p1Scores[indexPath.section - 1])"
            cell.rightLabel.text = "+\(p2Scores[indexPath.section - 1])"
            if(p1Scores[indexPath.section - 1] != p2Scores[indexPath.section - 1]){
                let p1ScoreHigher = p1Scores[indexPath.section - 1] > p2Scores[indexPath.section - 1]
                cell.leftBox.backgroundColor = p1ScoreHigher ? UIColor.greenColor() : UIColor.redColor()
                cell.rightBox.backgroundColor = p1ScoreHigher ? UIColor.redColor() : UIColor.greenColor()
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0 && indexPath.row == 0){
            return 60
        }
        return 120
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
}
