//
//  BaseServiceLocator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

final class BaseServiceLocator: ServiceLocator {
	
	lazy var imageLoading: ImageLoadingService = {
		WeakCachingImageLoadingService()
	}()
	
	lazy var lodingDataService: DataLoadingService = {
		BundleDataLoadingService()
	}()
	
	lazy var configService: ConfigurationService = {
		JSONConfigurationService(
			loadingService: lodingDataService
		)
	}()
	
}
