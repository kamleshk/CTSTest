//
//  AppDelegate.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	/// cerating and initilizing rootview controller  with navigationcontroller
	private lazy var navCont: UINavigationController = {
		let viewController = ListViewController(nibName: nil, bundle: nil) /// Initilizating listviewcontroller
		let navigationController = UINavigationController(rootViewController: viewController)
		return navigationController
	}()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = navCont /// adding a rootview controller to window as rootview controller
		self.window?.makeKeyAndVisible()///  making  window visible t
		return true
	}
	
}

