//
//  HCPositionUtil.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/5/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

/// Enumerated type that describes the possible
/// positions a player may play.
enum Position {
    case QuarterBack
    case RunningBack
    case WideReceiver
    case TightEnd
    case Kicker
    case DefensiveLine
}

/// Utility class for converting the
/// 'Position' enumerated type to and from
/// the 'String' data received from the HeadCoach
/// service.
class HCPositionUtil {
    /// Converts a position to a 'String' that is 
    /// 'user friendly' enough to be dislpayed on the screen.
    class func positionToName(pos: Position) -> String {
        switch pos {
        case .QuarterBack:
            return "Quarter Back"

        case .RunningBack:
            return "Running Back"

        case .WideReceiver:
            return "Wide Receiver"

        case .TightEnd:
            return "Tight End"

        case .Kicker:
            return "Kicker"

        default:
            return "Defence"
        }
    }

    /// Converts the input 'Position' to its 
    /// corresponding 'String' value.
    class func positionToString(pos: Position) -> String {
        switch pos {
        case .QuarterBack:
            return "QB"

        case .RunningBack:
            return "RB"

        case .WideReceiver:
            return "WR"

        case .TightEnd:
            return "TE"

        case .Kicker:
            return "K"

        default:
            return "DL"
        }
    }

    /// Converts the input 'String' to its
    /// corresponding 'Position' value.
    class func stringToPosition(pos: String) -> Position {
        switch pos {
        case "QB":
            return .QuarterBack

        case "RB":
            return .RunningBack

        case "WR":
            return .WideReceiver

        case "TE":
            return .TightEnd

        case "K":
            return .Kicker

        default:
            return .DefensiveLine
        }
    }

    /// Array based implementation of 'positionToString'
    class func positionsToStrings(pos: [Position]) -> [String] {
        var ret = [String]()
        for p in pos {
            ret.append(positionToString(p))
        }

        return ret
    }

    /// Array based implementation of 'stringToPosition'
    class func stringsToPositions(pos: [String]) -> [Position] {
        var ret = [Position]()
        for p in pos {
            ret.append(stringToPosition(p))
        }

        return ret
    }
}