//
//  Coordinator.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()
}
