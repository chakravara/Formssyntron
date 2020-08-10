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
  private var displaylist: [CountryList.Country]?
  private var disposeBag = DisposeBag()
  private var viewModel: CountryListViewModel!
  
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
    setUp()
    viewModel.getData()
  }
  
  private func setUp(){
    viewModel = CountryListViewModel()
    viewModel.router.view = self
    observe()
  }
  
  private func observe(){
    
    viewModel.searchSuccess
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self]  searchResult in
           guard let self = self else { return }
           self.displaylist = searchResult
           self.tableView.reloadData()
      }).disposed(by: disposeBag)
    
    viewModel.getDataSuccess
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] list in
           guard let self = self else { return }
           self.displaylist = list
           self.tableView.reloadData()
      }).disposed(by: disposeBag)

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
     viewModel.router.routeToMap(country: selected)
     
  }
}

// Search Bar Delegates
extension CountryListViewController: UISearchBarDelegate,
                                     UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let text =  searchController.searchBar.text else { return }
    let searched = viewModel.searchLogic(input: text)
    if let searchedList = searched {
      displaylist = searchedList
      tableView.reloadData()
    }
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
