//
//  CalendarEvent.swift
//  MyCalendar
//
//  Created by J Nastos on 12/18/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import Foundation

class CalendarEvent : NSObject {
    var title : String
    var dateString : String
    
    init(withTitle t : String, andDateString ds : String) {
        title = t
        dateString = ds
    }
    
    init(withCoder coder : NSCoder) {
        dateString = coder.decodeObjectForKey("dateString") as! String
        title = coder.decodeObjectForKey("title") as! String
    }
    
    func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(dateString, forKey: "dateString")
        coder.encodeObject(title, forKey: "title")
    }
}