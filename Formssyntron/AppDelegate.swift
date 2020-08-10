//
//  AppDelegate.swift
//  Formssyntron
//
//  Created by Xoxo on 9/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    guard
      let splitViewController = window?.rootViewController as? UISplitViewController,
      let leftNavController = splitViewController.viewControllers.first
        as? UINavigationController,
      let masterViewController = leftNavController.viewControllers.first
        as? CountryListViewController,
      let detailViewController = splitViewController.viewControllers.last
        as? MapViewController
      else { fatalError() }

    return true
  }


}

