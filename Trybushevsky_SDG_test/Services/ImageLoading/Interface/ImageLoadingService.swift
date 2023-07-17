//
//  ImageLoadingService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation
import UIKit

protocol ImageLoadingService {
	
	func loadImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?)

}
