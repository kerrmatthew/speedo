//
//  InterfaceController.swift
//  speedoWatch Extension
//
//  Created by Matthew Kerr on 19/05/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, SpeedoDelegate {

    var speedo = Speedo ()
    
    
    @IBOutlet var speedLabel: WKInterfaceLabel!
    @IBOutlet var headingLabel: WKInterfaceLabel!
    @IBOutlet var courseLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        speedo.delegate = self
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func speedDidChange(speed: Double) {
        speedLabel.setText( String(speed) )
    }
    func speedDidChange(course: Double) {
        courseLabel.setText(String(course))
    }

    func headingDidChange(heading: Double) {
        headingLabel.setText( String(heading) )
    }

    func session(_ session: WCSession,
                 didReceiveApplicationContext applicationContext: [String : Any]) {}

}
