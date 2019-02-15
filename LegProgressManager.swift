//
//  LegProgressManager.swift
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



import Foundation

protocol ARMRouteProgressManagerDelegate:class {
    
    func start(newStep: ARMStepProgress)
    func didUpdate(stepInstraction: String?, remainingDistance: CLLocationDistance?, manueverIcon: UIImage? )
    func didEnd(navigation step:ARMRoute.ARMStep)
    func start(newStep: ARMRoute.ARMStep, with stepAfter: ARMRoute.ARMStep?, priorStep:ARMRoute.ARMStep?)
    func performManuver(type:ManeuverTypeNavigation, steps:[ARMRoute.ARMStep])
    func distanceTravled(_ dinstance:CLLocationDistance)
    func enter(zone:Zone)
}

class ARMRouteProgressManager:NSObject
{
    var DEBUG:Bool { return UserDefaults.standard.bool(forKey: debugMode) }
    
    var stepIndex:Int {
        didSet{
            
            if DEBUG{ assert(stepIndex >= 0 && stepIndex < route.steps.endIndex, "step index out of bounds") }
            currentStepProgress.delegate = nil
            currentStepProgress = ARMStepProgress(step: currentStep)
            currentStepProgress.delegate = self
            
            delegate?.start(newStep: currentStepProgress)
            delegate?.start(newStep: currentStep, with: upComingStep, priorStep:priorStep)
        }
    }
    
    var remainingSteps: [ARMRoute.ARMStep]{
        return Array(route.steps.suffix(from: stepIndex + 1))
    }
    
    var durationRemaining:TimeInterval
    {
        return remainingSteps.map({  $0.expectedTimeTraveled  }).reduce(0, +)  + currentStepProgress.durationRemaning
    }
    
    var distanceRemaining:Double
    {
        return remainingSteps.map({ $0.distance }).reduce(0, +) + currentStepProgress.userDistanceToManeuverLocation
    }
    
    var priorStep:ARMRoute.ARMStep? {
        guard stepIndex - 1 >= 0 else {return nil}
        return route.steps[stepIndex - 1]
    }
    
    var currentStep:ARMRoute.ARMStep{
        return route.steps[stepIndex]
    }
    
    var upComingStep:ARMRoute.ARMStep?
    {
        guard stepIndex + 1 < route.steps.endIndex else {
            return nil
        }
        
        return route.steps[stepIndex + 1]
    }
    
    var followOnStep:ARMRoute.ARMStep?
    {
        guard stepIndex + 2 < route.steps.endIndex else {
            return nil
        }
        
        return route.steps[stepIndex + 2]
    }
    
    func isCurrent(_ step:ARMRoute.ARMStep) -> Bool{
        return currentStep == step
    }
    
    var distanceTraveled: CLLocationDistance {
        let distanceTraveled = route.steps.prefix(upTo: stepIndex).map { $0.distance }.reduce(0, +) + currentStepProgress.distanceTraveled
        
        return distanceTraveled
    }
    
    
    // delegation
    weak var delegate:ARMRouteProgressManagerDelegate?
    
    // properties
    fileprivate var didEnterRedZone:Bool = true
    fileprivate var currentStepProgress:ARMStepProgress
    fileprivate let routeSteps:[ARMRoute.ARMStep]
    fileprivate var route:ARMRoute
    fileprivate var userHasArrived:Bool = false

    
    init(route:ARMRoute) {
        
        self.route = route
        routeSteps = route.steps.compactMap({ return $0 })
        currentStepProgress = ARMStepProgress(step: routeSteps.first!)
        stepIndex = 0
        delegate?.start(newStep: currentStepProgress)
        super.init()
        
        // step manage delegate
        currentStepProgress.delegate = self
        
    }
    
    @objc public var nearbyCoordinates: [CLLocationCoordinate2D] {
        
        let priorCoords = priorStep?.coordinations ?? []
        let upcomingCoords = upComingStep?.coordinations ?? []
        let currentCoords = currentStep.coordinations ?? []
        let nearby = priorCoords + currentCoords + upcomingCoords
        
        if DEBUG{
            assert(!nearby.isEmpty, "Step must have coordinates")
        }
        return nearby
    }
    
    func update(userLocation:CLLocation)
    {
        currentStepProgress.updateDistnaceRemaining(from: userLocation)
        completeStep(currentStepProgress.isStepComplete())
        delegate?.distanceTravled(distanceTraveled)
        
        guard let visualInstraction = currentStep.instructionsDisplayedAlongStep?.first?.primaryInstruction,
            let image = ARMIconStyleKit.getNotificationManueverIcon(manueverType: visualInstraction.maneuverType, manueverDirection: visualInstraction.maneuverDirection, exitIndex: upComingStep?.exitIndex) else { return }
        
        var text = visualInstraction.text
        if upComingStep?.maneuverType == .arrive {
            
            /// change user message for place name, should be business name or street adress
            text = route.place.name
            
        }
        
        // update navigation user message
        //  - Parameters:
        //  - stepInstraction:   next manuver instruction
        //  - remainingDistance: remaining distance to next manuver
        //  - manueverIco:       manuever icon
        
        delegate?.didUpdate(stepInstraction: text, remainingDistance: currentStepProgress.userDistanceToManeuverLocation, manueverIcon: image)
        
    }
    
    func completeStep(_ complete : Bool)
    {
        
        if complete
        {
            if !isLastStep()
            {
                stepIndex += 1
                if !currentStepProgress.isShort{
                    
                    if let step = upComingStep
                    {
                        delegate?.performManuver(type: .startNormalMenuver, steps: [currentStep,step])
                        delegate?.start(newStep: currentStepProgress)
                    }
                }
            }else{
                
                // user complete route
                userHasArrived = true
                
                // for dismissing AR controller
                delegate?.didEnd(navigation: routeSteps[routeSteps.endIndex - 1])
                
            }
        }
        
    }
    
    typealias StepIndexDistance = (index: Int, distance: CLLocationDistance)
    
    func closestStep(to coordinate: CLLocationCoordinate2D) -> StepIndexDistance? {
        
        var currentClosest: StepIndexDistance?
        let remainingSteps = route.steps.suffix(from: stepIndex)
        
        for (currentStepIndex, step) in remainingSteps.enumerated() {
            guard let coords = step.coordinations,
                let closestCoordOnStep = Polyline(coords).closestCoordinate(to: coordinate)
                else { continue }
            
            let foundIndex = currentStepIndex + stepIndex
            
            // First time around, currentClosest will be `nil`.
            guard let currentClosestDistance = currentClosest?.distance else {
                
                currentClosest = (index: foundIndex, distance: closestCoordOnStep.distance)
                continue
            }
            
            if closestCoordOnStep.distance < currentClosestDistance {
                currentClosest = (index: foundIndex, distance: closestCoordOnStep.distance)
                
            }
        }
        
        return currentClosest
    }
    
    
    
    // helper functions
    func getStep(identifier:String) -> ARMRoute.ARMStep?
    {
        return routeSteps.filter { return $0.instructions == identifier }.first
    }
    
    func isLastInstruction() -> Bool
    {
        return stepIndex == routeSteps.endIndex - 2
    }
    
    func isLastStep() -> Bool
    {
        return stepIndex == routeSteps.endIndex - 1
    }
    
    func stepBefore(_ step:ARMRoute.ARMStep) -> ARMRoute.ARMStep?{
        guard let index = route.steps.index(where: { $0 == step  }) else {   return   nil}
        if index > 0 {
            return route.steps[index - 1]
        }
        return nil
    }
    
    func stepAfter(_ step:ARMRoute.ARMStep) -> ARMRoute.ARMStep?{
        guard let index = route.steps.index(where: { $0 == step  }) else {   return   nil}
        if index > 0 {
            return route.steps[index + 1]
        }
        return nil
    }
    
    
}

extension ARMRouteProgressManager:ARMStepProgressDelegate
{
    func didEnter(zone:Zone, stepProgress: ARMStepProgress) {
        if DEBUG{
            print("enter \(zone) zone")
        }
        if !isLastStep()
        {
            // alert for getting close to manuver
            delegate?.enter(zone: zone)
            if zone == .red {
                guard let upComingStep = upComingStep else {
                    return
                }
                switch upComingStep.distance < shortDistanceStep
                {
                case true:
                    // short manuver
                    //have to read next step either
                    if let followOnStep = followOnStep{
                        delegate?.performManuver(type: .shortMenuver, steps: [upComingStep,followOnStep])
                    }
                case false:
                    // normal manuver
                    delegate?.performManuver(type: .menuver, steps: [upComingStep])
                    
                }
            }
        }
        
    }
}

