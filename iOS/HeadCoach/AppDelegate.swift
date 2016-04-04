//
//  AppDelegate.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/16/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // we will not be using any storyboards, so the following sets up the primary (and only window)
        let nav = UINavigationController(rootViewController: HCLandingViewController())
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = nav // sets the root view controller for the application
        window?.makeKeyAndVisible()

        return true
    }
}