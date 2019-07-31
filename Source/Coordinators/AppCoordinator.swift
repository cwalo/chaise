//
//  AppCoordinator.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

protocol EventSelecting: AnyObject {
    func didSelectEvent(_ event: EventEntity)
}

final class AppCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController

        // style navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let searchVC = SearchViewController.instantiate()
        searchVC.coordinator = self
        searchVC.viewModel = MockEventSearchViewModel()
        navigationController.pushViewController(searchVC, animated: true)
    }
}

extension AppCoordinator: EventSelecting {
    func didSelectEvent(_ event: EventEntity) {
        let detailVC = DetailViewController.instantiate()
        detailVC.event = event
        navigationController.pushViewController(detailVC, animated: true)
    }
}
