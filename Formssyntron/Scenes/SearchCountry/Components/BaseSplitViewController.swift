//
//  BaseSplitViewController.swift
//  Formssyntron
//
//  Created by Xoxo on 10/8/2563 BE.
//  Copyright © 2563 wooz. All rights reserved.
//

import Foundation
import UIKit

class BaseSplitViewController: UISplitViewController,
                                  UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }

    func splitViewController(
             _ splitViewController: UISplitViewController,
             collapseSecondary secondaryViewController: UIViewController,
             onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
