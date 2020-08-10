//
//  CountryListViewModel.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class CountryListViewModel {
  
  var router: CountryListRouter!
  private var service: CountryListService!
  private var list: CountryListServiceModel.Get.response?
  
  var getDataSuccess = PublishSubject<[CountryList.Country]>()
  var searchSuccess = PublishSubject<[CountryList.Country]>()
  
  init(router: CountryListRouter = CountryListRouter(),
       service: CountryListService = CountryListService()) {
    self.router = router
    self.service = service
  }
  
  func getData() {
    list = service.getData()
    guard let list = list?.countryList else { return }
    getDataSuccess.onNext(list)
  }
  func searchFilter(input: String) {
    guard let searchResult = searchLogic(input: input) else { return }
    searchSuccess.onNext(searchResult)
  }
  
}


extension CountryListViewModel {
  
  func searchLogic(input: String) -> [CountryList.Country]? {
    guard let data = list else { return nil }
    guard case let textInput = input , textInput != "" && textInput != " " else { return nil }
    guard case let count = data.countryList.count, count > 0 else { return nil }
    let countries = data.countryList
    let filteredName = countries.filter({ $0.name.lowercased()
                                                 .hasPrefix(input.lowercased())})
    let orderedName = filteredName.sorted {
                      $0.name.lowercased() < $1.name.lowercased() }
    let orderedCountryCode = orderedName.sorted {
                             $0.country.lowercased() < $1.country.lowercased() }
    return orderedCountryCode
     
  }
}
