//
//  Date.swift
//  drawer
//
//  Created by amir lahav on 27.7.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation

extension Date
{
    func convertToTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"

        return dateFormatter.string(from: self)        
    }
    
}
