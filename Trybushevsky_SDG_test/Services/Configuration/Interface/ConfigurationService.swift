//
//  Configuration.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

protocol ConfigurationService {

	func startStepModel(completion: ((StepModel?) -> Void))
	func stepModel(for id: String, completion: ((StepModel?) -> Void))
	
}
