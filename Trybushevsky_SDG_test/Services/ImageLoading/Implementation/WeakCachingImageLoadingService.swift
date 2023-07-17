//
//  WeakCachingImageLoadingService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import UIKit

final class WeakCachingImageLoadingService: NetworkImageLoadingService {
	
	private let cachingService: WeakCachingSyncService

	override init() {
		cachingService = WeakCachingSyncService()
		
		super.init()
	}

	override func loadImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?) {
		let cacheSearchPath = url.absoluteString
		if let image = cachingService.image(for: cacheSearchPath) {
			completion?(.success(image))
		} else {
			super.loadImage(url: url) { [weak self] result in
				guard let self else {
					completion?(.failure(GeneralError.internal))
					return
				}

				switch result {
				case .success(let image):
					self.cachingService.save(image: image, for: cacheSearchPath)
					completion?(.success(image))
				case .failure(let error):
					completion?(.failure(error))
				}
			}
		}
		
	}

}

fileprivate class WeakCachingSyncService {
	
	private let cacheQueue: DispatchQueue
	private var cache: [String : UIImage] = [:]
	
	init() {
		cacheQueue = DispatchQueue(label: "com.test.weak_cache_image_loading", attributes: .concurrent)
	}

	func image(for path: String) -> UIImage? {
		cacheQueue.sync {
			cache[path]
		}
	}
	
	func save(image: UIImage, for path: String) {
		cacheQueue.sync(flags: .barrier) {
			cache[path] = image
		}
	}

}
