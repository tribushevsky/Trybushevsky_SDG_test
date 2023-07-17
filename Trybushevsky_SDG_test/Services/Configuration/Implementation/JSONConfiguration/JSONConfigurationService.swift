//
//  JSONConfigurationService.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

final class JSONConfigurationService {

	private var _startStepModel: StepModel?
	private var stepsData: [String : StepModel]?
	
	private let loadingService: DataLoadingService
	
	init(loadingService: DataLoadingService) {
		self.loadingService = loadingService
	}

}

// MARK: - ConfigurationService

extension JSONConfigurationService: ConfigurationService {
	
	func startStepModel(completion: ((StepModel?) -> Void)) {
		if let startStepModel = _startStepModel {
			completion(startStepModel)
		} else {
			updateData { [weak self] in
				completion(self?._startStepModel)
			}
		}
	}
	
	func stepModel(for id: String, completion: ((StepModel?) -> Void)) {
		if let stepData = stepsData {
			completion(stepData[id])
		} else {
			updateData { [weak self] in
				completion(self?.stepsData?[id])
			}
		}
	}

}

// MARK: - Constant

extension JSONConfigurationService {
	
	private enum Constant {
		static var startStepType: String { "start" }
	}

}

// MARK: - Update Data

extension JSONConfigurationService {

	private func updateData(completion: (() -> Void)) {
		loadingService.loadSourceData { [weak self] result in
			guard
				let self,
				case .success(let data) = result
			else {
				completion()
				return
			}
			
			do {
				let config = try JSONDecoder().decode(ConfigSourceModel.self, from: data)
				
				let nodes = config.nodes.map {
					($0.id, BaseStepModel(config: $0))
				}
				
				self.stepsData = Dictionary(nodes) { _, last in
					last
				}
				
				self._startStepModel = self.stepsData?.values.first { $0.type == Constant.startStepType }
				completion()
			} catch {
				completion()
			}
		}
	}

}
