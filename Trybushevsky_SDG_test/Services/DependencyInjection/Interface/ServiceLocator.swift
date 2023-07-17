//
//  ServiceLocator.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

protocol ServiceLocator {

	var imageLoading: ImageLoadingService { get }
	var configService: ConfigurationService { get }

}
