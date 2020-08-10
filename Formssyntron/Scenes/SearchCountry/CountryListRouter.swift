//
//  CountryListRouter.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import UIKit

class CountryListRouter {
  
  weak var view: CountryListViewController!
  
  func routeToMap(country: CountryList.Country) {
     let sb =  UIStoryboard.init(name: "CountryList", bundle: nil)
     let destination  =  sb.instantiateViewController(identifier: "MapViewController") as MapViewController
     destination.displayData = country
     view.splitViewController?.showDetailViewController(destination, sender: nil)
   }
  
}
