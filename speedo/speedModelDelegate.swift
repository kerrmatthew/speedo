//
//  speedModelDelegate.swift
//  speedo
//
//  Created by Matthew Kerr on 26/04/17.
//  Copyright © 2017 Matthew Kerr. All rights reserved.
//

import Foundation

protocol speedModelDelegate {
    func speedDidChange(speed: Double, course: Double )
    func headingDidChange(heading: Double)
}
