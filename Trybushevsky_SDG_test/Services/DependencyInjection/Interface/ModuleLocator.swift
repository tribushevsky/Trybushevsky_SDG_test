//
//  ModuleLocator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import UIKit
import RxSwift

protocol ModuleLocator: AnyObject {

	func root() -> RootController
	func loading(finishLoading: Observable<Void>) -> LoadingController
	func step(
		stepModel: StepModel,
		routingMode: RoutingMode,
		navigationController: UINavigationController
	) -> StepController
	
}
