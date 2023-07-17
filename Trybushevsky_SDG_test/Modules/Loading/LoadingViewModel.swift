//
//  LoadingViewModel.swift
//  WaterTracke
//
//  Created by vldmr on 16/07/2023.
//  Copyright 2023 VLDMR. All rights reserved.
//

import RxSwift
import RxCocoa

struct BaseLoadingContext: LoadingContext {
    
	let finishLoading: Observable<Void>

}

final class LoadingViewModel: ViewModelType {
	typealias In = Input
    typealias Out = Output

    struct Input {
		let willAppearTrigger: Driver<Void>
		let contentIsHidden: Driver<Bool>
    }

    struct Output {
		let isContentHidden: Driver<Bool>
		let tools: Driver<Void>
    }

    let context: LoadingContext
    let useCase: LoadingUseCase
    let navigator: LoadingNavigator

    init(context: LoadingContext, useCase: LoadingUseCase, navigator: LoadingNavigator) {
        self.context = context
        self.useCase = useCase
        self.navigator = navigator
    }

	func transform(input: Input) -> Output {
		let showContent = input.willAppearTrigger.map { false }
		let hideContent = context
			.finishLoading
			.asDriverOnErrorDoNothing()
			.take(1).map { true }
		
		let tools = input
			.contentIsHidden
			.filter { $0 }
			.mapToVoid()
			.do(onNext: { [weak self] in
				self?.navigator.nextAndComplete(element: ())
			})

        return Output(
			isContentHidden: Driver.merge(showContent, hideContent),
			tools: tools
		)
    }
}

// MARK: - Handlers

extension LoadingViewModel {

}
