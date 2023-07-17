//
//  NetworkImageLoadingService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import UIKit

enum NetworkImageLoadingError: Error {

	case mapping

}

class NetworkImageLoadingService: ImageLoadingService {
	
	func loadImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?) {
		let config = URLSessionConfiguration.default
		config.timeoutIntervalForResource = TimeInterval(Constant.maxLoadingTime)
		
		let session = URLSession(configuration: config)
		session.dataTask(with: url) { data, _, error in
			if let error = error {
				completion?(.failure(error))
			} else {
				guard
					let data = data,
					let imageData = UIImage(data: data)
				else {
					completion?(.failure(NetworkImageLoadingError.mapping))
					return
				}
				
				completion?(.success(imageData))
			}
		}.resume()
	}

}

// MARK: - Constant

extension NetworkImageLoadingService {
	
	private enum Constant {
		static let maxLoadingTime: UInt = 2
	}

}
