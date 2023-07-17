//
//  StepViewModel.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

struct BaseStepContext: StepContext {
	
	let stepModel: StepModel
	let routingMode: RoutingMode

}

final class StepViewModel: ViewModelType, StepIdHandable {
	typealias In = Input
    typealias Out = Output

	struct Input {
		let willAppearTrigger: Driver<Void>
		let selectedChoice: Driver<Int>
	}

	struct Output {
		let title: Driver<String>
		let image: Driver<UIImage?>
		let choices: Driver<[String]>
		let isContentHidden: Driver<(Bool, Bool)>
		let tools: Driver<Void>
	}

    let context: StepContext
    let useCase: StepUseCase
    let navigator: StepNavigator
	var stepId: String { context.stepModel.id }
	
	private let finishLoadingRelay: PublishRelay<Void> = .init()

    init(context: StepContext, useCase: StepUseCase, navigator: StepNavigator) {
        self.context = context
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
		let currentStep = Driver.just(context.stepModel)
		let routingMode = Driver.just(context.routingMode)

		let availableChoices = currentStep.map { $0.choices }
		let image = handleLoadImage(
			trigger: input.willAppearTrigger,
			imagePath: currentStep.map { $0.image }
		).do(onNext: { [weak self] _ in
			self?.finishLoadingRelay.accept(())
		}).startWith(nil)

		let showLoadingTrigger = input.willAppearTrigger
			.delay(.milliseconds(100))
			.withLatestFrom(image)
			.filter { $0 == nil }
			.map { _ in true }
			.startWith(false)

		let imageIsReadyBeforeSpinner = image
			.skip(1)
			.unwrappedNever()
			.withLatestFrom(showLoadingTrigger)
			.filter { !$0 }

		let showLoading = handleShowLoading(trigger: showLoadingTrigger.skip(1).mapToVoid())

		let isContentHidden: Driver<(Bool, Bool)> = Driver
			.merge(
				showLoading.map { (false, true) },
				imageIsReadyBeforeSpinner.map { _ in (false, false) }
			).startWith((true, false))
			.distinctUntilChanged { lhs, rhs in
				lhs.0 == rhs.0
			}

		let tools = Driver<Void>.merge(
			handle(
				choiceTrigger: input.selectedChoice.throttle(.milliseconds(500)),
				availableChoices: availableChoices,
				routingMode: routingMode
			)
		)

		return Output(
			title: currentStep.map { $0.title },
			image: image,
			choices: availableChoices.map { $0.map { $0.text } },
			isContentHidden: isContentHidden,
			tools: tools
		)
    }
}

// MARK: - Constant

extension StepViewModel {

	enum Constant {
		static var imagePlaceholder: UIImage { UIImage(named: "sad_cat")! }
	}
	
}

// MARK: - Handlers

extension StepViewModel {

	private func handleLoadImage(
		trigger: Driver<Void>,
		imagePath: Driver<String>
	) -> Driver<UIImage?> {
		trigger
			.withLatestFrom(imagePath)
			.map { URL(string: $0) }
			.flatMapLatest { [unowned self] url in
				guard let url else {
					return Driver.just(Constant.imagePlaceholder)
				}

				return self.useCase
					.loadImage(for: url)
					.asDriver(onErrorJustReturn: Constant.imagePlaceholder)
					.map { Optional($0) }
			}
	}

	private func handleShowLoading(
		trigger: Driver<Void>
	) -> Driver<Void> {
		trigger
			.flatMapLatest { [unowned self] in
				self.navigator
					.showLoading(finishLoading: finishLoadingRelay.asObservable())
					.asDriverOnErrorDoNothing()
			}
	}

	private func handle(
		choiceTrigger: Driver<Int>,
		availableChoices: Driver<[NextStepModel]>,
		routingMode: Driver<RoutingMode>
	) -> Driver<Void> {
		choiceTrigger
			.withLatestFrom(availableChoices) { ($0, $1) }
			.map { $0.1[safe: $0.0]?.nextNode }
			.unwrappedNever()
			.flatMapLatest { [unowned self] nextStep in
				self.useCase
					.step(for: nextStep)
					.asDriver(onErrorJustReturn: nil)
					.unwrappedNever()
			}
			.withLatestFrom(routingMode) { ($0, $1) }
			.flatMapLatest { [unowned self] params in
				switch params.1 {
				case .line:
					return self.navigator
						.routeToStep(
							stepModel: params.0,
							routingMode: params.1
						)
						.asDriverOnErrorDoNothing()
				case .loop:
					return self.navigator
						.cycleRouteToStep(
							stepModel: params.0,
							routingMode: params.1
						)
						.asDriverOnErrorDoNothing()
				}
			}
	}

}
