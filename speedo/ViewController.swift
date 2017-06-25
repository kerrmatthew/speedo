//
//  ViewController.swift
//  speedo
//
//  Created by Matthew Kerr on 25/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, speedModelDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var readout: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var pointer: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let speedo = speedModel ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speedo.delegate = self
        
        mapView.mapType = .satelliteFlyover
        mapView.showsBuildings = true
        mapView.isPitchEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func speedDidChange(speed: Double, course: Double) {
        readout.text = String(speed)
        courseLabel.text = String(course)
    }
    
    func headingDidChange(heading: Double) {
        pointer.transform = CGAffineTransform(rotationAngle: CGFloat(heading) / 180 * 3.14 )
    }
    
    func locationDidChange(location: CLLocationCoordinate2D, accuracy: CLLocationAccuracy) {
        self.updatePath()
        
        if let lastLocation = speedo.locations.last {
            let camera = MKMapCamera(lookingAtCenter: lastLocation.coordinate,
                                     fromDistance: 100 + lastLocation.horizontalAccuracy*5,
                                    pitch: 30,
                                    heading: lastLocation.course)
            mapView.setCamera(camera, animated: true)
        }
        
        

        
    }
    
    
    private func updatePath() {
        
        let coordinates = speedo.locations.map(
            { location -> CLLocationCoordinate2D in
                return location.coordinate
            }
        )
        
        if let currentPath = mapView.overlays.last {
          mapView.remove(currentPath)
        }
        mapView.add(MKPolyline(coordinates: coordinates, count: coordinates.count))
    }

    // MARK Map view delegate methods
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .red
        polylineRenderer.lineWidth = 2
        return polylineRenderer
    }
    
}

