//
//  RootNavigator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import RxSwift
import RxCocoa

final class BaseRootNavigator: Navigator<Void>, RootNavigator {
	
	func routeToStep(stepModel: StepModel, routingMode: RoutingMode) -> Observable<Void> {
		guard
			let navigationController = navigationController,
			let moduleLocator = moduleLocator
		else {
			return Observable.never()
		}
		
		let controller = moduleLocator.step(
			stepModel: stepModel,
			routingMode: routingMode,
			navigationController: navigationController
		)
		
		return navigationController.rx
			.push(controller, animated: true)
			.map { [unowned controller] in controller.viewModel.navigator }
			.flatMapLatest { $0.output }
			.do(onCompleted: { [weak navigationController] in
				navigationController?.popViewController(animated: true)
			})
	}

}
