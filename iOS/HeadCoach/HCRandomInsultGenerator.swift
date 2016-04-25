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
    let descriptors = ["throws like ", "kicks like ", "runs like ", "is more unpredictable than ",
                       "catches like ", "hits like ", "fumbles more than "]
    let kickers : [String: [String]] = ["throws like ": ["a Tyrannosaurus Rex with arthritis.", "an epilectic playing hot potato with the paparazzi."],
                "kicks like ": ["a horse... with four broken legs.", "Batman's parents.", "Charlie Brown."],
                "runs like ": ["Pheidippides after the 26th mile.", "a truck with no gasoline.", "Steven Hawking."],
                "is more unpredictable than ": ["Doug's arrival times.", "your mother's mood swings."],
                "catches like ": ["the ball is lathered in oil."],
                "hits like ": ["a 4-year-old girl in a pillow fight."],
                "fumbles more than ": ["a Computer Science student."]]
    
    let generalKickers = ["garbage.", "trash.", "they're not even trying.", "rubbish.", "a toddler.", "my grandmother.",
                          "Joe Young.", "Ian Malerich.", "Mitchell Johnson.", "Davor Civsa."]
    
    
    func generateInsult() -> String{
        
        // has a chance to insult a random group instead of generating a random insult
        var diceRoll = Int(arc4random_uniform(12))
        if (diceRoll == 0 || diceRoll == 7){
            diceRoll = Int(arc4random_uniform(50)) + 1
            return "Group \(diceRoll)'s code is so poorly documented, Donald Trump wants it deported."
        }
        else if(diceRoll == 1){
            return "Get off your knees, you're blowing the game!"
        }
        else if(diceRoll == 2){
            return "Your fantasy football roster is a complete joke to me."
        }
        else if(diceRoll == 3){
            return "I just took the weirdest dump! It looks just like your fantasy football team."
        }
        else if(diceRoll == 4){
            return "Sorry your fantasy football team's clever name isn't offsetting its crappy results."
        }
        else if(diceRoll == 5){
            return "Sorry your fantasy football team exposed how little you understand about football."
        }
        else if(diceRoll == 6){
            return "Sorry your team's greatest achievement is making you wish you were better at picking your fantasy football teams."
        }
        
        
        let subjectChoice = Int(arc4random_uniform(UInt32(subjects.count)))
        let descriptorChoice = Int(arc4random_uniform(UInt32(descriptors.count)))
        
        let subject = subjects[subjectChoice]
        let descriptor = descriptors[descriptorChoice]
        
        let kickerRoll = Int(arc4random_uniform(3))
        var kicker: String = ""
        
        if(kickerRoll == 1){
            diceRoll = Int(arc4random_uniform(UInt32(generalKickers.count)))
            kicker = generalKickers[diceRoll]
        }
        else{
            let kickerChoice = Int(arc4random_uniform(UInt32(kickers[descriptors[descriptorChoice]]!.count)))
            kicker = kickers[descriptor]![kickerChoice]
        }
        
        return subject + descriptor + kicker
    }

    
    
}