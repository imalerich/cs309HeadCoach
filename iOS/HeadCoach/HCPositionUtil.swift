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
}