//
//  StepModels.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

protocol NextStepModel {

	var text: String { get }
	var nextNode: String { get }

}

protocol StepModel {
	
	var id: String { get }
	var type: String { get }
	var title: String { get }
	var image: String { get }
	var choices: [NextStepModel] { get }

	var isStart: Bool { get }

}
