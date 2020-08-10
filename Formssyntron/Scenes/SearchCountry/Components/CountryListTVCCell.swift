//
//  CountryListTVCCell.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import UIKit

class CountryListTVCCell: UITableViewCell {
  
  @IBOutlet private weak var city: UILabel!
  @IBOutlet private weak var country: UILabel!
  @IBOutlet private weak var latlon: UILabel!
  
  func displayData(data: CountryList.Country) {
    self.city.text = data.name
    self.country.text = data.country
    self.latlon.text = processLatLonText(coor: data.coord)
  }
  
  private func processLatLonText(coor: CountryList.Coordinate) -> String {
    let str =  "Lat: \(coor.lat) Lon: \(coor.lon)"
    return str
  }
}
