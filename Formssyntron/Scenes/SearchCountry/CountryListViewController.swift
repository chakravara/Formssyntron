//
//  CountryListViewController.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import RxSwift


final class CountryListViewController: UITableViewController {
  
  private var resultSearchController = UISearchController()
  private var services = CountryListService()
  private var list: CountryListServiceModel.Get.response?
  private var displaylist: [CountryList.Country]?
  
  private var router: CountryListRouter!
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setUp()
  }
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUp()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSearhBar()
    displaySetup()
    list = services.getData()
    setUp()
  }
  
  private func setUp(){
    router = CountryListRouter()
    router.view = self
  }
  
}

// Display Delegates
extension CountryListViewController {
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    guard let list = displaylist else { return 0 }
    return list.count
  }
  
  override func tableView( _ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTVCCell",
                                                   for: indexPath) as? CountryListTVCCell,
          let list = displaylist else { return UITableViewCell() }
    
    let data = list[indexPath.row]
    cell.displayData(data: data)
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
     guard let list = displaylist else { return }
     let selected = list[indexPath.row]
     router.routeToMap(country: selected)
     
  }
}

// Search Bar Delegates
extension CountryListViewController: UISearchBarDelegate,
                                     UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let text =  searchController.searchBar.text else { return }
    guard let list = self.list else { return }
    let searched = searchLogic(input: text, data: list)
    if let searchedList = searched {
      displaylist = searchedList
      tableView.reloadData()
    }
   }
 }

// Search Logic
extension CountryListViewController {
  
  func searchLogic(input: String,
                   data: CountryListServiceModel.Get.response) -> [CountryList.Country]? {
    guard case let textInput = input , textInput != "" && textInput != " " else { return nil }
    guard case let count = data.countryList.count , count > 0 else { return nil }
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

// initial setup
extension CountryListViewController {
  
  func displaySetup() {
    self.splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
  }
  
  func setUpSearhBar() {
    resultSearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        tableView.tableHeaderView = controller.searchBar
        return controller
    })()

    // Reload the table
    tableView.reloadData()
  }
}
