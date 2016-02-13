//
//  EventViewController.swift
//  MyCalendar
//
//  Created by J Nastos on 12/14/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import Foundation
import UIKit

class EventViewController : UIViewController {
    
    var calendarEvent : CalendarEvent?
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    
    override func viewDidLoad() {
        titleLabel.text = calendarEvent?.title
        dateLabel.text = calendarEvent?.dateString
    }
}