//
//  HCRandomInsultGenerator.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/16/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation

class HCRandomInsultGenerator{
    
    static let sharedInstance = HCRandomInsultGenerator()
    
    let subjects = ["Your team ", "Your roster ", "Your lineup "]
    let descriptors = ["throws like ", "kicks like ", "runs like ", "is more unreliable than ",
                       "catches like ", "hits like "]
    let kickers : [String: [String]] = ["throws like ": ["a Tyrannosaurus Rex with arthritis.", "an epilectic playing hot potato with the paparazzi."],
                "kicks like ": ["a horse... with four broken legs."],
                "runs like ": ["Pheidippides after the 26th mile.", "a truck with no gasoline."],
                "is more unreliable than ": ["Doug's arrival times.", "your mother's mood swings."],
                "catches like ": ["the ball is lathered in oil."],
                "hits like ": ["a 4-year-old girl in a pillow fight."]]
    
    
    
    func generateInsult() -> String{
        
        // has a 20% chance to insult Group 46 instead of generating a random insult
        let diceRoll = Int(arc4random_uniform(5))
        if (diceRoll == 0){
            return "Group 46's code is so poorly documented, Donald Trump wants it deported."
        }
        
        
        let subjectChoice = Int(arc4random_uniform(UInt32(subjects.count)))
        let descriptorChoice = Int(arc4random_uniform(UInt32(descriptors.count)))
        let kickerChoice = Int(arc4random_uniform(UInt32(kickers[descriptors[descriptorChoice]]!.count)))
        
        let subject = subjects[subjectChoice]
        let descriptor = descriptors[descriptorChoice]
        let kicker = kickers[descriptor]![kickerChoice]
        
        return subject + descriptor + kicker
    }

    
    
}