//
//  MonthsTableViewController.swift
//  MyCalendar
//
//  Created by J Nastos on 12/14/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import Foundation
import UIKit

class MonthsTableViewController : UITableViewController {
    
    let monthsDataSet = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthsDataSet.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        cell.textLabel?.text = monthsDataSet[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MonthSegue") {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            
            if let dest = segue.destinationViewController as? DaysTableViewController {
                dest.title = monthsDataSet[selectedRow!]
                dest.monthNumber = selectedRow! + 1
            }
        }
    }
    
}