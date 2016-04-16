//
//  HCRandomInsultGenerator.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/16/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation

class HCRandomInsultGenerator{
    
    let subjects = ["Your team ", "Your roster ", "Your lineup"]
    let descriptors = ["throws like ", "kicks like ", "runs like ", "is more unreliable than ",
                       "catches like ", "couldn't block ", "hits like "]
    var kickers : [String: [String]] = ["throws like ": [], "kicks like ": [], "runs like ": [],
                    "is more unreliable than ": [], "catches like ": [], "couldn't block ": [], "hits like ": []]
    
    func generateInsult() -> String{
        let subjectChoice = Int(arc4random_uniform(subjects.count as! UInt32))
        let descriptorChoice = Int(arc4random_uniform(descriptors.count as! UInt32))
        let kickerChoice = Int(arc4random_uniform((kickers[descriptors[descriptorChoice]]!).count as UInt32))
        
    }
    
}