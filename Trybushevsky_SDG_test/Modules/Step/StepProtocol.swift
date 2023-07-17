//
//  StepProtocol.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

protocol StepIdHandable {
	
	var stepId: String { get }
}

enum RoutingMode {
	
	case loop
	case line

}

protocol StepContext {
    
	var stepModel: StepModel { get }
	var routingMode: RoutingMode { get }

}

protocol StepUseCase {
    
	func step(for id: String) -> Single<StepModel?>
	func loadImage(for url: URL) -> Single<UIImage>

}

protocol StepNavigator: Navigator<Void> {

	func showLoading(finishLoading: Observable<Void>) -> Observable<Void>
	func routeToStep(stepModel: StepModel, routingMode: RoutingMode) -> Observable<Void>
	func cycleRouteToStep(stepModel: StepModel, routingMode: RoutingMode) -> Observable<Void>

}
