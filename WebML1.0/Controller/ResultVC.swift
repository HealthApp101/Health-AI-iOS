//
//  DiabetesResult.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import GoogleMaps

class ResultVC : UIViewController{
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var mapView: UIView!
    
    var result : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.lineBreakMode = .byWordWrapping
        resultsLabel.numberOfLines = 0
        resultsLabel.text = result
        resultsLabel.textColor = .white
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView1 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView = mapView1
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
       marker.map = mapView1
        
    }

}
