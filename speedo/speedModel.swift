//
//  speedModel.swift
//  speedo
//
//  Created by Matthew Kerr on 25/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import Foundation
import CoreLocation

class speedModel: NSObject, CLLocationManagerDelegate {
 
    let locationManager = CLLocationManager ()
    var delegate: speedModelDelegate?
    
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
             delegate?.speedDidChange( speed: location.speed )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        delegate?.headingDidChange(heading: newHeading.trueHeading)

    }
    
    
}
