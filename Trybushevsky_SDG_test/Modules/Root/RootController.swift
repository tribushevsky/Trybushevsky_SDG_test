//
//  RootController.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import UIKit
import RxSwift
import RxCocoa

final class RootController: ViewController<RootViewModel> {

	@IBOutlet private weak var modesStackView: UIStackView!
	@IBOutlet private weak var loopButton: UIButton!
	@IBOutlet private weak var lineButton: UIButton!
	
	override func viewDidLoad() {
	    super.viewDidLoad()
	    
	    setupBinding()
	}

}

// MARK: - Setup

extension RootController {

	private func setupBinding() {
	    let input = RootViewModel.Input(
			willAppearTrigger: rx.viewWillAppear.take(1).asDriverOnErrorDoNothing(),
			loopTrigger: loopButton.rx.tap.asDriver(),
			lineTrigger: lineButton.rx.tap.asDriver()
		)

	    let output = viewModel.transform(input: input)
		
		output.tools.drive().disposed(by: disposeBag)
	}

}

// MARK: - Reactive

extension Reactive where Base: RootController {

}
