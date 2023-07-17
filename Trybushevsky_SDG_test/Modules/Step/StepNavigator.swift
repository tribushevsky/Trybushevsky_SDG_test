//
//  StepNavigator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

final class BaseStepNavigator: Navigator<Void>, StepNavigator {
	
	func showLoading(finishLoading: Observable<Void>) -> Observable<Void> {
		guard
			let navigationController = navigationController,
			let moduleLocator = moduleLocator
		else {
			return Observable.never()
		}
		
		let controller = moduleLocator.loading(finishLoading: finishLoading)
		controller.modalPresentationStyle = .overFullScreen

		return navigationController.rx
			.present(controller, animated: false)
			.map { [unowned controller] in controller.viewModel.navigator }
			.flatMapLatest { $0.output }
			.do(onCompleted: { [weak navigationController] in
				navigationController?.dismiss(animated: false)
			})
	}

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
	
	func cycleRouteToStep(stepModel: StepModel, routingMode: RoutingMode) -> Observable<Void> {
		guard
			let navigationController = navigationController
		else {
			return Observable.never()
		}

		let existingStepController = navigationController.viewControllers.first { controller in
			((controller as? ViewController<StepViewModel>)?.viewModel as? StepIdHandable)?.stepId == stepModel.id
		}
		
		guard let existingStepController else {
			return routeToStep(stepModel: stepModel, routingMode: routingMode)
		}

		return navigationController.rx
			.popTo(existingStepController, animated: true)
	}

}
