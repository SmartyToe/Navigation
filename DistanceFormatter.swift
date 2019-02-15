//
//  Double.swift
//  drawer
//
//  Created by amir lahav on 22.7.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation


extension Double
{
    func getDistance(formatter:DistanceFormtter) -> String
    {
        switch formatter {

        case .short:
            
            switch self {
            case 0...1000:
                return String(format: "%0.1f km", self/1000)
            default:
                return String(format: "%d km", Int(self/1000))
            }
        
        case .full:
            switch self {
            
            case 0...100:
                let distanceInKm:Double = self / 1000.0
                let roundedDistance:Double = distanceInKm.roundToDecimal(2) * 1000.0
                
                return String(format: "%0.0f m", roundedDistance)
            
            case 100...1000:
                let round = Int(self/50)
                return String(format: "%d m", round * 50)
            
            default:

                return String(format: "%0.1f km", self/1000)
            }
        
        case .navigation:
            
            switch self {
            case 0...1000:
                let distanceInKm:Double = self / 1000.0
                let roundedDistance:Double = distanceInKm.roundToDecimal(2) * 1000.0

                return String(format: "%0.0f m", roundedDistance)
                
            default:
                
                return String(format: "%0.1f km", self/1000)
            }
        }
    }
    
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }

    
}

enum DistanceFormtter
{
    case short
    case full
    case navigation
}
