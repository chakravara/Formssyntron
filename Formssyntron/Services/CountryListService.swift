//
//  CountryListService.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import RxSwift

struct CountryListServiceModel: Codable {
  
  struct Get {
    struct request: Encodable {
      
    }
    
    struct response: Decodable {
      var countryList: [CountryList.Country]
    }
  }
}

class CountryListService {
  
  func getData() -> CountryListServiceModel.Get.response? {
    guard let path = Bundle.main.path(forResource: "cities",
                                           ofType: "json") else { return nil }
    do {
    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path),
                               options: .mappedIfSafe)
    let decoder = JSONDecoder()
      do {
        let objects = try decoder.decode( [CountryList.Country].self,
                                          from: jsonData)
        let response =  CountryListServiceModel.Get.response(countryList: objects)
        return response
      }
    }
    catch {
      // handle error
    }
    return nil
  }
}
