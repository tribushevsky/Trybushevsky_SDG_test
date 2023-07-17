//
//  BaseModuleLocator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import UIKit
import RxSwift

final class BaseModuleLocator: ModuleLocator {

	private let serviceLocator: ServiceLocator
	
	init(serviceLocator: ServiceLocator) {
		self.serviceLocator = serviceLocator
	}

	func root() -> RootController {
		let navigationConroller = UINavigationController()
		let context = BaseRootContext()
		let useCase = BaseRootUseCase(configService: serviceLocator.configService)
		let navigator = BaseRootNavigator(
			navigationController: navigationConroller,
			moduleLocator: self
		)

		let viewModel = RootViewModel(
			context: context,
			useCase: useCase,
			navigator: navigator
		)
		
		let controller = RootController(viewModel: viewModel)
		navigationConroller.setViewControllers([controller], animated: false)
		
		return controller
	}
	
	func loading(finishLoading: Observable<Void>) -> LoadingController {
		let context = BaseLoadingContext(finishLoading: finishLoading)
		let useCase = BaseLoadingUseCase()
		let navigator = BaseLoadingNavigator(moduleLocator: self)
		let viewModel = LoadingViewModel(
			context: context,
			useCase: useCase,
			navigator: navigator
		)
		
		return LoadingController(viewModel: viewModel)
	}
	
	func step(
		stepModel: StepModel,
		routingMode: RoutingMode,
		navigationController: UINavigationController
	) -> StepController {
		let context = BaseStepContext(
			stepModel: stepModel,
			routingMode: routingMode
		)
		let useCase = BaseStepUseCase(
			configService: serviceLocator.configService,
			imageLoading: serviceLocator.imageLoading
		)
		let navigator = BaseStepNavigator(navigationController: navigationController, moduleLocator: self)
		let viewModel = StepViewModel(context: context, useCase: useCase, navigator: navigator)
		
		return StepController(viewModel: viewModel)
	}
	
}
