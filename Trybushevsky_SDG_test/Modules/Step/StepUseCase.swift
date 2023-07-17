//
//  StepUseCase.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

final class BaseStepUseCase: StepUseCase {
    
	private let configService: ConfigurationService
	private let imageLoading: ImageLoadingService
	
	init(
		configService: ConfigurationService,
		imageLoading: ImageLoadingService
	) {
		self.configService = configService
		self.imageLoading = imageLoading
	}
	
	func step(for id: String) -> Single<StepModel?> {
		Single.create { [weak self] single in
			guard let self else {
				single(.failure(GeneralError.internal))
				return Disposables.create()
			}

			self.configService.stepModel(for: id) { stepModel in
				single(.success(stepModel))
			}

			return Disposables.create()
		}
	}
	
	func loadImage(for url: URL) -> Single<UIImage> {
		Single.create { [weak self] single in
			guard let self else {
				single(.failure(GeneralError.internal))
				return Disposables.create()
			}
			
			self.imageLoading.loadImage(url: url) { result in
				switch result {
				case .success(let image):
					single(.success(image))
				case .failure(let error):
					single(.failure(error))
				}
			}
			
			return Disposables.create()
		}
	}

}
