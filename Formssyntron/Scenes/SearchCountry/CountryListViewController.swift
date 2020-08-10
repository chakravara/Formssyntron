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
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSearhBar()
    displaySetup()
    let x = services.getData()
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
    
  }
  
 }

extension CountryListViewController {
//  func searchLogic(input: String,
//                   data: CountryListServiceModel.Get.response) {
//    guard case let count = data.countryList.count , count > 0 else { return }
//    let countries = data.countryList
//    let filtered = countries.filter { (oneCountry: CountryList.Country) -> Bool in
//      return oneCountry.self
//       //return candy.name.lowercased().contains(searchText.lowercased())
//     }
//  }
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
