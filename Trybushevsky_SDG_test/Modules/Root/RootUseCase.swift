//
//  RootUseCase.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

final class BaseRootUseCase: RootUseCase {
    
	private let configService: ConfigurationService
	
	init(configService: ConfigurationService) {
		self.configService = configService
	}
	
	var startStep: Single<StepModel?> {
		Single.create { [weak self] single in
			guard let self else {
				single(.failure(GeneralError.internal))
				return Disposables.create()
			}

			self.configService.startStepModel { stepModel in
				single(.success(stepModel))
			}

			return Disposables.create()
		}
	}

}
