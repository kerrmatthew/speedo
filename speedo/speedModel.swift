//
//  speedModel.swift
//  speedo
//
//  Created by Matthew Kerr on 25/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import Foundation
import CoreLocation
import WatchConnectivity

class speedModel: NSObject, CLLocationManagerDelegate, WCSessionDelegate {
 
    let locationManager = CLLocationManager ()
    var delegate: speedModelDelegate?
    var watchSession: WCSession?
    var locations: [CLLocation] = []
    var lastHeading: Double?
    
    
    override init ()
    {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if(CLLocationManager.headingAvailable()) {
            locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last {
            
            // update the speed
             delegate?.speedDidChange( speed: location.speed, course: location.course )
            updateWatchExtension( [ "speed": location.speed, "course": location.course ] )
            
            // also update lat and long, and give us some location data
            delegate?.locationDidChange( location: location.coordinate, accuracy: location.horizontalAccuracy )
            self.locations.append(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        self.lastHeading = newHeading.trueHeading
        delegate?.headingDidChange(heading: newHeading.trueHeading)
        updateWatchExtension( [ "heading": newHeading.trueHeading ] )

    }
    
    func updateWatchExtension(_ values: Dictionary<String, Double> ) {
        
        if WCSession.isSupported() {
            if (watchSession == nil) {
                watchSession = WCSession.default()
                watchSession!.delegate = self
            }
            if let ws = watchSession {
                if ws.activationState != .activated {
                    ws.activate()
                }
                if ( ws.isPaired && ws.isWatchAppInstalled ) {
                    try? ws.updateApplicationContext(values)
                }
            }
        }
    }
    
    
    
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    
    /** ------------------------- iOS App State For Watch ------------------------ */
    
    /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    
    /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
    func sessionDidDeactivate(_ session: WCSession) {}
    
    
    /** Called when any of the Watch state properties change. */
    public func sessionWatchStateDidChange(_ session: WCSession) {}
    

    
    
    
}
