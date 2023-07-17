//
//  BundleDataLoadingService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 16.07.23.
//

import Foundation

final class BundleDataLoadingService {
	
}

// MARK: - DataLoadingService

extension BundleDataLoadingService: DataLoadingService {
	
	func loadSourceData(completion: ((Result<Data, Error>) -> Void)) {
		guard let path = Bundle.main.path(forResource: "source", ofType: "json") else {
			return
		}

		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
			completion(.success(data))
		} catch let error {
			completion(.failure(error))
		}
	}
	
}

