//
//  ConfigModels.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import Foundation

struct ConfigSourceModel: Decodable {

	let nodes: [ConfigStepModel]
	
	enum CodingKeys: CodingKey {
		case nodes
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.nodes = try container.decode(
			FailableDecodableArray<ConfigStepModel>.self,
			forKey: .nodes
		).elements
	}

}

struct ConfigStepModel: Decodable {
	
	let id: String
	let type: String
	let title: String
	let image: String
	let choices: [ConfigNextStepModel]

	enum CodingKeys: CodingKey {
		case id
		case type
		case title
		case image
		case choices
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.id = try container.decode(String.self, forKey: .id)
		self.type = try container.decode(String.self, forKey: .type)
		self.title = try container.decode(String.self, forKey: .title)
		self.image = try container.decode(String.self, forKey: .image)
		self.choices = try container.decode(
			FailableDecodableArray<ConfigNextStepModel>.self,
			forKey: .choices
		).elements
	}

}

struct ConfigNextStepModel: Decodable {

	let text: String
	let nextNode: String

	enum CodingKeys: CodingKey {
		case text
		case nextNode
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.text = try container.decode(String.self, forKey: .text)
		self.nextNode = try container.decode(String.self, forKey: .nextNode)
	}

}
