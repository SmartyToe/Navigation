//
//  SpeechFormatter.swift
//  drawer
//
//  Created by amir lahav on 10.9.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation
import MapboxDirections


class SpeechFormmater:NSObject
{
    func instraction(for menuver:ManeuverTypeNavigation, steps:[ARMRoute.ARMStep]) -> String?
    {
        
        if steps.count > 2 { return nil }
        
        switch menuver {
        case .startNormalMenuver:
            
            guard let priorStep = steps.first,
                let step = steps.last,
                let maneuverDirection = step.maneuverDirection,
                let direction = MessegeFormatter.getMessage(manueverType: step.maneuverType, manueverDirection: maneuverDirection, exitIndex: step.exitIndex)
                else {
                    return nil
                    
            }
            
            let speechDistance = priorStep.distance.getDistance(formatter: .navigation)
            
            return "In \(speechDistance) \(direction)"
            
            
        case .shortMenuver:
            
            guard let first = steps.first, let second = steps.last,
                
                let firstManeuverDirection = first.maneuverDirection,
                let firstDirection = MessegeFormatter.getMessage(manueverType: first.maneuverType, manueverDirection: firstManeuverDirection, exitIndex: first.exitIndex),
                
                let secondManeuverDirection = second.maneuverDirection,
                let secondDirection = MessegeFormatter.getMessage(manueverType: second.maneuverType, manueverDirection: secondManeuverDirection, exitIndex: second.exitIndex)
                
                
                else {
                    return nil
                    
            }
    
            
            let secondSpeechDistance = first.distance.getDistance(formatter: .navigation)
            
            return "\(firstDirection) and then In \(secondSpeechDistance) \(secondDirection)"
            
            
        case .menuver:
            
            guard let step = steps.first,
                let maneuverDirection = step.maneuverDirection,
                let direction = MessegeFormatter.getMessage(manueverType: step.maneuverType, manueverDirection: maneuverDirection, exitIndex: step.exitIndex)
                
                else {return nil}
            return "\(direction)"
            
        }
        
    }
    
}
