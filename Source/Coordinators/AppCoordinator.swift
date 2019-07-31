//
//  AppCoordinator.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController

        // style navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let searchVC = SearchViewController.instantiate()
        navigationController.pushViewController(searchVC, animated: true)
    }
}
