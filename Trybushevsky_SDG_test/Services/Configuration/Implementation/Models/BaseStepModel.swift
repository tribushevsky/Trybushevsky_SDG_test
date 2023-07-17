//
//  BaseStepModel.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

struct BaseNextStepModel: NextStepModel {

	let text: String
	let nextNode: String

}

struct BaseStepModel: StepModel {

	let id: String
	let type: String
	let title: String
	let image: String
	let choices: [NextStepModel]
	
	var isStart: Bool {
		type == "start"
	}

}

// MARK: - Config Init

extension BaseNextStepModel {
	
	init(config: ConfigNextStepModel) {
		self.text = config.text
		self.nextNode = config.nextNode
	}

}

extension BaseStepModel {
	
	init(config: ConfigStepModel) {
		self.id = config.id
		self.type = config.type
		self.title = config.title
		self.image = config.image
		self.choices = config.choices.map {
			BaseNextStepModel(config: $0)
		}
	}

}
