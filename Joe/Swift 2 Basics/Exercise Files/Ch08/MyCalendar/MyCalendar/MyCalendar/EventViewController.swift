//
//  EventViewController.swift
//  MyCalendar
//
//  Created by Joseph Young on 2/14/16.
//  Copyright © 2016 Joseph Young. All rights reserved.
//

import Foundation
import UIKit

class EventViewController : UIViewController{
    
    var calendarEvent : CalendarEvent?
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    
    override func viewDidLoad() {
        titleLabel.text = calendarEvent?.title
        dateLabel.text = calendarEvent?.dateString
    }
}