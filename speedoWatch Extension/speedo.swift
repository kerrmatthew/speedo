//
//  speedModel.swift
//  speedo
//
//  Created by Matthew Kerr on 25/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import Foundation
import WatchConnectivity

class Speedo: NSObject, WCSessionDelegate {

    var watchSession: WCSession?
    var delegate: SpeedoDelegate?
    
    override init ()
    {
        super.init()
        if WCSession.isSupported() {
            let watchSession = WCSession.default()
            watchSession.delegate = self
            watchSession.activate()
        }
    }
    
    
    
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        applicationContext.forEach { (key: String, value: Any) in
            switch key {
                case "speed":
                    delegate!.speedDidChange(speed: value as! Double)
                case "heading":
                    delegate!.headingDidChange(heading: value as! Double)
                default:
                    break
            }
        }
    }
    
}


protocol SpeedoDelegate {
    func speedDidChange(speed: Double)
    func headingDidChange(heading: Double)
}
