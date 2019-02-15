//
//  IconSyleManager.swift
//  Go
//
//  Created by Amir lahav on 15/02/2019.
//  Copyright © 2019 LA Computers. All rights reserved.
//

import Foundation
import UIKit

class IconStyleKit: NSObject {
    
    static func getNotificationManueverIcon(manueverType:ManeuverType, manueverDirection:ManeuverDirection?, exitIndex:Int?) -> UIImage?
        
    {
        let manueverDirection = manueverDirection ?? ManeuverDirection.straightAhead
        switch manueverType {
            
        case .depart:
            return #imageLiteral(resourceName: "continue stright")
            
        case .arrive:
            switch manueverDirection{
            case .right,.sharpRight,.slightRight:
                return #imageLiteral(resourceName: "arrive")
                
            case .left,.sharpLeft,.slightLeft:
                return #imageLiteral(resourceName: "arrive")
                
            default :
                return #imageLiteral(resourceName: "arrive")
            }
            
        case .reachFork:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return #imageLiteral(resourceName: "fork slight right")
            case .slightLeft, .left, .sharpLeft:
                return #imageLiteral(resourceName: "fork slight left")
            default:
                return #imageLiteral(resourceName: "continue stright")
            }
            
        case .takeOnRamp, .merge:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return #imageLiteral(resourceName: "on ramp right")
            case .slightLeft, .left, .sharpLeft:
                return #imageLiteral(resourceName: "on ramp left")
            default:
                return #imageLiteral(resourceName: "continue stright")
            }
            
        case .takeOffRamp:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return #imageLiteral(resourceName: "off ramp right")
            case .slightLeft, .left, .sharpLeft:
                return #imageLiteral(resourceName: "off ramp left")
            default:
                return #imageLiteral(resourceName: "continue stright")
            }
            
            
        case .takeRoundabout,.exitRotary,.exitRoundabout, .takeRotary,.turnAtRoundabout:
            
            if let index = exitIndex{
                switch index {
                case 1:
                    return #imageLiteral(resourceName: "roundabout 90")
                case 2:
                    return #imageLiteral(resourceName: "roundabout 180")
                case 3...6:
                    return #imageLiteral(resourceName: "roundabout 270")
                default: return #imageLiteral(resourceName: "continue stright")
                }
            }
            return #imageLiteral(resourceName: "continue stright")
            
            
        default:
            switch manueverDirection{
            case .none:
                return #imageLiteral(resourceName: "continue stright")
            case .sharpRight:
                return #imageLiteral(resourceName: "sharp right")
            case .right:
                return #imageLiteral(resourceName: "right")
            case .slightRight:
                return  #imageLiteral(resourceName: "slight right")
            case .straightAhead:
                return  #imageLiteral(resourceName: "continue stright")
            case .slightLeft:
                return  #imageLiteral(resourceName: "slight left")
            case .left:
                return  #imageLiteral(resourceName: "left")
            case .sharpLeft:
                return #imageLiteral(resourceName: "sharp left")
            case .uTurn:
                return #imageLiteral(resourceName: "uTurn left")
            }
        }
        
        
    }
    
    
    static func getMapIcons(manueverType:ManeuverType, manueverDirection:ManeuverDirection?, exitIndex:Int?) -> UIImage?
    {
        
        let manueverDirection = manueverDirection ?? ManeuverDirection.straightAhead
        
        switch manueverType {
            
        case .depart:
            return #imageLiteral(resourceName: "continue map")
            
        case .arrive:
            
            switch manueverDirection{
            case .right,.sharpRight,.slightRight:
                return #imageLiteral(resourceName: "destenation right map")
                
            case .left,.sharpLeft,.slightLeft:
                return #imageLiteral(resourceName: "destenation left map")
                
            default :
                return #imageLiteral(resourceName: "destenation right map")
            }
            
        case .reachFork, .takeOffRamp:
            switch manueverDirection{
            case .slightRight, .right, .sharpRight:
                return #imageLiteral(resourceName: "slight right map")
            case .slightLeft, .left, .sharpLeft:
                return #imageLiteral(resourceName: "slight left map")
            default:
                return nil
            }
            
            
        case .takeRoundabout,.exitRotary,.exitRoundabout, .takeRotary,.turnAtRoundabout:
            
            switch exitIndex{
            case 1:
                return #imageLiteral(resourceName: "right map")
            case 2:
                return #imageLiteral(resourceName: "continue map")
            default:
                return #imageLiteral(resourceName: "left map")
            }
            
            
            
        default:
            switch manueverDirection{
            case .none:
                return nil
            case .sharpRight:
                return #imageLiteral(resourceName: "sharp right map")
            case .right:
                return #imageLiteral(resourceName: "right map")
            case .slightRight:
                return  #imageLiteral(resourceName: "slight right map")
            case .straightAhead:
                return  #imageLiteral(resourceName: "continue map")
            case .slightLeft:
                return  #imageLiteral(resourceName: "slight left map")
            case .left:
                return  #imageLiteral(resourceName: "left map")
            case .sharpLeft:
                return #imageLiteral(resourceName: "sharp left map")
            case .uTurn:
                return nil
            }
        }
        
        
    }
}
