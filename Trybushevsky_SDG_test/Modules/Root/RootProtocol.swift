//
//  RootProtocol.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

enum RootError: Error {
	
	case stepNotFound

}

protocol RootContext {
    
}

protocol RootUseCase {
    
	var startStep: Single<StepModel?> { get } 

}

protocol RootNavigator: Navigator<Void> {

	func routeToStep(stepModel: StepModel, routingMode: RoutingMode) -> Observable<Void>

}
