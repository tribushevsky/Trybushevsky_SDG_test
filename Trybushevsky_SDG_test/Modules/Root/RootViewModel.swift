//
//  RootViewModel.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

struct BaseRootContext: RootContext {
    
}

final class RootViewModel: ViewModelType {
	typealias In = Input
    typealias Out = Output

    struct Input {
		let willAppearTrigger: Driver<Void>
		let loopTrigger: Driver<Void>
		let lineTrigger: Driver<Void>
    }

    struct Output {
		let tools: Driver<Void>
    }

    let context: RootContext
    let useCase: RootUseCase
    let navigator: RootNavigator

    init(context: RootContext, useCase: RootUseCase, navigator: RootNavigator) {
        self.context = context
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
		let firstStep = useCase.startStep
			.asDriver(onErrorJustReturn: nil)
			.unwrappedNever()

		let firstStepTrigger: Driver<RoutingMode> = Driver.merge(
			input.lineTrigger.throttle(.milliseconds(500)).map { .line },
			input.loopTrigger.throttle(.milliseconds(500)).map { .loop }
		)
		
		let tools = handleFirstStep(
			trigger: firstStepTrigger,
			firstStep: firstStep
		)

        return Output(
			tools: tools
		)
    }

}

// MARK: - Private / Handlers

extension RootViewModel {
	
	private func handleFirstStep(
		trigger: Driver<RoutingMode>,
		firstStep: Driver<StepModel>
	) -> Driver<Void> {
		trigger
			.withLatestFrom(firstStep) { ($0, $1) }
			.flatMapLatest { [unowned self] params in
				self.navigator
					.routeToStep(
						stepModel: params.1,
						routingMode: params.0
					)
					.asDriverOnErrorDoNothing()
		}
	}
}
