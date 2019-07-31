//
//  AppDelegate.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navController)
        appCoordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}

