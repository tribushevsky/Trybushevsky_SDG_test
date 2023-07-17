//
//  Navigator.swift
//  WaterTracke
//
//  Created by Vladimir Tribushevsky on 12/24/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Navigator<T> {

    private var privateOutput: PublishSubject<T> = PublishSubject<T>()
	private(set) weak var moduleLocator: ModuleLocator?

    weak var navigationController: UINavigationController?
    
    var output: Observable<T> {
        return privateOutput.asObservable()
    }
    
    func next(element: T) {
        privateOutput.onNext(element)
    }
    
    func complete() {
        privateOutput.onCompleted()
    }
    
    func nextAndComplete(element: T) {
        privateOutput.onNext(element)
        privateOutput.onCompleted()
    }
    
    init(
		navigationController: UINavigationController? = nil,
		moduleLocator: ModuleLocator
	) {
        self.navigationController = navigationController
		self.moduleLocator = moduleLocator
    }
}
