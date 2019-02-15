//
//  MessegeManager.swift
//  drawer
//
//  Created by amir lahav on 4.8.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation
import MapboxDirections




class MessegeFormatter:NSObject
{
    static func getMessage(manueverType:ManeuverType, manueverDirection:ManeuverDirection, exitIndex:Int?) -> String?
    {        
        switch manueverType {
        
        case .depart:
            return nil
        case .arrive:
            return "You will arrive"
        case .reachFork:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return "Keep right at the fork"
            case .slightLeft, .left, .sharpLeft:
                return "Keep left at the fork"
            default:
                return nil
            }
            
        case .takeOnRamp:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return "Take the ramp on the right"
            case .slightLeft, .left, .sharpLeft:
                return "Take the ramp on the left"
            default:
                return nil
            }
            
        case .takeOffRamp:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return "Exit the ramp on the right"
            case .slightLeft, .left, .sharpLeft:
                return "Exit the ramp on the left"
            default:
                return nil
            }
        case .passNameChange:
            
            switch manueverDirection{
                case .none:
                    return nil
                case .sharpRight:
                    return "Make a sharp right"
                case .right:
                    return "Continue right"
                case .slightRight:
                    return  "Continue slightly right"
                case .straightAhead:
                    return  "Continue straight"
                case .slightLeft:
                    return  "Continue slightly left"
                case .left:
                    return  "Continue left"
                case .sharpLeft:
                    return "Make a sharp left"
                case .uTurn:
                    return "Make a u turn"
                }
        
        case .takeRoundabout,.exitRotary,.exitRoundabout, .takeRotary,.turnAtRoundabout:
            if let index = exitIndex{
                switch index {
                case 1:
                     return "take the 1st exit"
                case 2:
                    return "take the 2nd exit"
                case 3:
                    return "take the 3rd exit"
                case 4:
                    return "take the 4th exit"
                case 5:
                    return "take the 5th exit"
                case 6:
                    return "take the 6th exit"
                default: return nil
                }
            }
            
            switch manueverDirection {
                
            case .none:
                return nil
            case .sharpRight:
                return "Make a sharp right"
            case .right:
                return "Turn right"
            case .slightRight:
                return  "Make a slight right"
            case .straightAhead:
                return  "Go straight"
            case .slightLeft:
                return  "Make a slight left"
            case .left:
                return  "Turn left"
            case .sharpLeft:
                return "Make a sharp left"
            case .uTurn:
                return "Make a u turn"
            }
                        
            
        default:
            switch manueverDirection{
            case .none:
                return nil
            case .sharpRight:
                return "Make a sharp right"
            case .right:
                return "Turn right"
            case .slightRight:
                return  "Make a slight right"
            case .straightAhead:
                return  "Go straight"
            case .slightLeft:
                return  "Make a slight left"
            case .left:
                return  "Turn left"
            case .sharpLeft:
                return "Make a sharp left"
            case .uTurn:
                return "Make a u turn"
            }
        }
        
    }
    
}

