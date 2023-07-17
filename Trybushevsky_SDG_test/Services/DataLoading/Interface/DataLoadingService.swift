//
//  DataLoadingService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 16.07.23.
//

import Foundation

protocol DataLoadingService {
	
	func loadSourceData(completion: ((Result<Data, Error>) -> Void))

}
