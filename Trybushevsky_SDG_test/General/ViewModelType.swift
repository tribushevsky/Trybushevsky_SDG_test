//
//  ViewModelType.swift
//  WaterTracke
//
//  Created by Vladimir Tribushevsky on 12/21/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

protocol ViewModelType {
    
	associatedtype In
    associatedtype Out
    
    func transform(input: In) -> Out

}
