//
//  AppDelegate.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
	private let serviceLocator = BaseServiceLocator()
	private lazy var moduleLocator: BaseModuleLocator = {
		.init(serviceLocator: serviceLocator)
	}()

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		return routeToRoot()
	}

}

// MARK: - Root Module Route

extension AppDelegate {
	
	private func routeToRoot() -> Bool {
		let controller = moduleLocator.root()
		
		guard let navigationController = controller.navigationController else {
			return false
		}
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}

}

