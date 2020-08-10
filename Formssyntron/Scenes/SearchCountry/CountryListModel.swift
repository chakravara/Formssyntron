//
//  CountryListModel.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation

struct CountryList: Codable{
  
  struct Country: Decodable{
    var country: String
    var name: String
    var _id: Int
    var coord: Coordinate
  }
  
  struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
  }
  
}
