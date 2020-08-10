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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSearhBar()
    displaySetup()
    list = services.getData()
  }
  
  
}

// Display Delegates
extension CountryListViewController {
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  override func tableView( _ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTVCCell",
                                             for: indexPath)
    return cell
  }
}
// Search Bar Delegates
extension CountryListViewController: UISearchBarDelegate,
                                     UISearchResultsUpdating {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("A")
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    print("B")
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    print("C")
    // simplfied to lowercase
    // filter by text
    guard let text =  searchController.searchBar.text else { return }
    guard let list = self.list else { return }
    searchLogic(input: text, data: list)
  }
  
 }

extension CountryListViewController {
  
  func searchLogic(input: String,
                   data: CountryListServiceModel.Get.response) {
    guard case let textInput = input , textInput != "" && textInput != " " else { return }
    guard case let count = data.countryList.count , count > 0 else { return }
    let countries = data.countryList
    let filteredName = countries.filter({ $0.name.lowercased()
                                                 .hasPrefix(input.lowercased())})
    let orderedName = filteredName.sorted {
                      $0.name.lowercased() < $1.name.lowercased() }
    let orderedCountryCode = orderedName.sorted {
                             $0.country.lowercased() < $1.country.lowercased() }
     
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
