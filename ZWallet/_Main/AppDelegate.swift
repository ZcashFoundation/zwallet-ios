//
//  AppDelegate.swift
//  ZWallet
//
//  Created by loj on 23.12.18.
//  Copyright © 2018 XMR Systems LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let navigationController = UINavigationController()
        navigationController.setToolbarHidden(true, animated: false)

        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isOpaque = false

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.tintColor = UIColor.black
        self.window?.rootViewController = navigationController

        let iocContainer = IocContainer()

        self.appCoordinator = AppCoordinator(navigationController: navigationController,
                                             iocContainer: iocContainer)
        self.appCoordinator.start()

        self.window?.makeKeyAndVisible()

        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Bold", size: 34)!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 18)!
        ]
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

