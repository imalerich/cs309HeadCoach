//
//  SingleDayTableViewController.swift
//  MyCalendar
//
//  Created by J Nastos on 12/14/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import Foundation
import UIKit

class SingleDayTableViewController : UITableViewController {
    
    
    var monthNumber = -1
    var dayNumber = -1
    
    var events : [AnyObject] = Array()
    
    override func viewDidLoad() {
        print("\(monthNumber)-\(dayNumber)")
    }
    
    @IBAction func addButtonPressed(sender : UIBarButtonItem) {
        
        let newEvent = "Test Event \(events.count + 1)"
        
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        let ce = CalendarEvent(withTitle: newEvent, andDateString: defaultsKey)
        
        let encodedCE = NSKeyedArchiver.archivedDataWithRootObject(ce)
        events.append(encodedCE)
        
        NSUserDefaults.standardUserDefaults().setObject(events, forKey: defaultsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //events.append(newEvent)
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            events.removeAtIndex(indexPath.row)
            
            let defaultsKey = "\(monthNumber)-\(dayNumber)"
            NSUserDefaults.standardUserDefaults().setObject(events, forKey: defaultsKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let sections = NSIndexSet(index: 0)
            tableView.reloadSections(sections, withRowAnimation: .Fade)
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        let arrayOfEvents = NSUserDefaults.standardUserDefaults().arrayForKey(defaultsKey)
        if let arrayOfEvents = arrayOfEvents {
            events = arrayOfEvents
        }
        
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        if let eventObject = events[indexPath.row] as? NSData {
            let ce = NSKeyedUnarchiver.unarchiveObjectWithData(eventObject) as! CalendarEvent
            cell.textLabel?.text = ce.title
        }
        
        //cell.textLabel?.text = events[indexPath.row]
        
        return cell
    }
    
}