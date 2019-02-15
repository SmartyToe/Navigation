//
//  Navigation Constant.swift
//  Go
//
//  Created by Amir lahav on 15/02/2019.
//  Copyright © 2019 LA Computers. All rights reserved.
//

import Foundation

/// acording to Luca Guala, Engineer and Planner at https://www.quora.com/What-is-the-average-walking-speed-of-a-human is usually 1.25 m/s = 4.5 km/h = 2.8 MPH
public let ARMAverageWalkingSpeed:CLLocationSpeed = 1.25

/// radius around the end of the manuever
public let RouteControllerManeuverZoneRadius: CLLocationDistance = 35

/// Maximum Distance away from route Before Recalculating in meters
public let RouteControllerMaximumDistanceBeforeRecalculating: CLLocationDistance = 35

/// Maximum Distance away from route for snapping user location
public let RouteControllerUserLocationSnappingDistance:CLLocationDistance = 25

/// short distance step
public let shortDistanceStep:CLLocationDistance = 100

/// minimus alert radius from manuever
public let minmumAlertRadius:CLLocationDistance = 18

/// red zone alert radius from manuever
public let redZoneAlertRadius:CLLocationDistance = 25

/// orange zone alert radius from manuever
public let orangeZoneAlertRadius:CLLocationDistance = 27

/// red zone alert radius from manuever
public let yellowZoneAlertRadius:CLLocationDistance = 50

/// green zone alert radius from start leg
public let greenZoneAlertRadius:CLLocationDistance = 20

/// minimus alert radius from manuever
public let minmumGreenAlertRadius:CLLocationDistance = 5

/// complete step radius from manuever
public let completeStepRadius:CLLocationDistance = 10

/// minimum distance from initial reading instraction
public let minimumDistanceForReadinigInitialInstraction:CLLocationDistance = 40

/// distance waling for removing guiding arrow
public let minimumDistanceWalkingBeforeRemovingGuidingArrow:CLLocationDistance = 15

/// minimum deviation for Horizontal Accuracy for updating true north
public let qualifiedLocationHorizontalAccuracy = 9.0


/// minimum horizantal accuracy before poping up calibration dialog
public let minimumHorizontalAccuracy = "minimumHorizontalAccuracy"

/// user has watch onboarding dialog
public let onboardingDialog = "onboardingDialog"
