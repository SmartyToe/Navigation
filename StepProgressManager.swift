//
//  StepProgressManager.swift
//  Go
//
//  Created by Amir lahav on 15/02/2019.
//  Copyright © 2019 LA Computers. All rights reserved.
//


//navigation is build from 3 parts:
//1. route: higher part of user navigation. route contains 1 or more legs. route has source location and destination
//2. leg: represent user point of intrest, for example leg can be walk from current location to nearest hotel.
//leg contain 1 or more steps
//3. step: smallest part of user navigation. represent the vector path from each intersection to another

// step progress manager class responsble to manage user step progress and notify to leg progress

import Foundation
import CoreLocation
import Turf
import Polyline

// notify progress manager for enterting region of intrest
protocol ARMStepProgressDelegate:class {
    
    func didEnter(zone:Zone, stepProgress:ARMStepProgress)
}

enum Zone
{
    // far from manuever location
    case yellow
    
    // half way from manuever location
    case orange
    
    // near manuever location
    // look also at redZoneAlertRadius
    case red
    
    // start of step
    case green
}



class ARMStepProgress
{
    // protocol delegate
    weak var delegate:ARMStepProgressDelegate?
    
    // compute properties
    var isShort:Bool {
        return step.distance < shortDistanceStep
    }
    
    // notifications
    var shouldRedZonePushNotification:Bool = true
    var shouldOrnageZonePushNotification:Bool = true
    var shouldGreenZonePushNotification:Bool = true
    
    var userDistanceToManeuverLocation:CLLocationDistance
    {
        didSet {
            
            if 0...greenZoneAlertRadius ~= distanceTraveled && shouldGreenZonePushNotification{
                delegate?.didEnter(zone: .green, stepProgress: self)
                
                shouldGreenZonePushNotification = false
            }
            
            /// reseting the world before adding signs
            /// should push only once
            /// user is between redZoneAlertRadius to orangeZoneAlertRadius
            
            if  redZoneAlertRadius...orangeZoneAlertRadius ~= userDistanceToManeuverLocation && shouldOrnageZonePushNotification {
                
                delegate?.didEnter(zone: .orange, stepProgress: self)
                
                shouldOrnageZonePushNotification = false
                
            }
            
            if  minmumAlertRadius...redZoneAlertRadius ~= userDistanceToManeuverLocation && shouldRedZonePushNotification && !shouldOrnageZonePushNotification{
                
                /// notify user is close to manuever
                /// should push only once
                
                delegate?.didEnter(zone: .red, stepProgress: self)
                
                shouldRedZonePushNotification = false
            }
        }
    }
    
    // getters properities
    var distanceTraveled:CLLocationDistance {
        return step.distance - userDistanceToManeuverLocation
    }
    
    var fractionTraveled:Double
    {
        return distanceTraveled/step.distance
    }
    
    var durationRemaning:TimeInterval {
        return userDistanceToManeuverLocation / step.averageWalkingSpeed
    }
    
    var upcomingIntersection: Intersection? {
        
        // user is heading to this Intersection
        guard let intersections = intersectionsIncludingUpcomingManeuverIntersection, intersections.startIndex..<intersections.endIndex-1 ~= intersectionIndex else {
            return nil
        }
        
        return intersections[intersections.index(after: intersectionIndex)]
        
    }
    
    var followOnIntersection: Intersection? {
        
        // Intersection after upcomingIntersection
        
        guard let intersections = intersectionsIncludingUpcomingManeuverIntersection, intersections.startIndex..<intersections.endIndex-1 ~= intersectionIndex + 1 else {
            return nil
        }
        
        return intersections[intersections.index(after: intersectionIndex + 1)]
        
    }
    
    var currentIntersection: Intersection? {
        
        guard let intersections = intersectionsIncludingUpcomingManeuverIntersection,
            intersections.startIndex..<intersections.endIndex ~= intersectionIndex else {
                return nil
        }
        
        return intersections[intersectionIndex]
    }
    
    
    // properties
    let step:ARMRoute.ARMStep
    var intersectionIndex: Int = 0
    var intersectionsIncludingUpcomingManeuverIntersection: [Intersection]?
    var intersectionDistances: Array<CLLocationDistance>?
    var userDistanceToUpcomingIntersection: CLLocationDistance?
    
    
    // initiation
    init(step:ARMRoute.ARMStep) {
        
        // step configuration
        self.step = step
        self.userDistanceToManeuverLocation = step.distance
        self.intersectionIndex = 0
        
    }
    
    
    func updateDistnaceRemaining(from userLocation:CLLocation)
    {
        
        // update the Distnace Remaining to complete current step (var: userDistanceToManeuverLocation)
        guard let coordinations = step.coordinations,
            let lastCoordinations = coordinations.last else { return }
        
        userDistanceToManeuverLocation = Polyline(coordinations).distance(from:userLocation.coordinate, to: lastCoordinations)
        
    }

    func isStepComplete() -> Bool
    {
        return userDistanceToManeuverLocation < completeStepRadius
    }
}

