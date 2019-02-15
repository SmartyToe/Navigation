//
//  TimeInterval.swift
//  drawer
//
//  Created by amir lahav on 19.7.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation


extension TimeInterval
{
    func formatInterval() -> String?
    {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = [ .default ]

        if self > 24 * 60 * 60 {
            formatter.allowedUnits = [ .hour, .day ]

        }else if self < 60{
            formatter.allowedUnits = [ .second ]
        }else{
            formatter.allowedUnits = [ .minute, .hour, .day ]
        }
        
        guard let timeFormated = formatter.string(from: self) else { return nil }
        
        /// remove ',' from timeFormated
        let travelTime = timeFormated.replacingOccurrences(of: ",", with: " ", options: .literal, range: nil)
        return travelTime
    }
}
