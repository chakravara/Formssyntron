//
//  MapViewController.swift
//  Formssyntron
//
//  Created by Xoxo on 10/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet private var mapView: MKMapView!
  var displayData:  CountryList.Country?
  var annotationView = MKMarkerAnnotationView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let display = displayData else { return }
    let initialLocation = CLLocation(latitude: display.coord.lat,
                                     longitude: display.coord.lon)
    mapView.centerToLocation(initialLocation)
    
    let artwork = Artwork(
      title: display.name,
      locationName: display.country,
      coordinate: CLLocationCoordinate2D(latitude: display.coord.lat,
                                         longitude: display.coord.lon))
    mapView.addAnnotation(artwork)
  }
  
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 5000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}


