//
//  ViewController.swift
//  speedo
//
//  Created by Matthew Kerr on 25/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, speedModelDelegate {
    
    @IBOutlet weak var readout: UILabel!
    @IBOutlet weak var pointer: UILabel!

    let speedo = speedModel ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speedo.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func speedDidChange(speed: Double) {
        readout.text = String(speed)
    }
    
    func headingDidChange(heading: Double) {
        pointer.transform = CGAffineTransform(rotationAngle: CGFloat(heading) / 180 * 3.14 )
    }

    
}

