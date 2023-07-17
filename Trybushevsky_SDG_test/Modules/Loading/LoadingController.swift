//
//  LoadingController.swift
//  WaterTracke
//
//  Created by vldmr on 16/07/2023.
//  Copyright 2023 VLDMR. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoadingController: ViewController<LoadingViewModel> {

	@IBOutlet fileprivate weak var contentView: UIView!
	
	fileprivate let contentIsHiddenRelay: PublishRelay<Bool> = .init()
	
	override func viewDidLoad() {
	    super.viewDidLoad()
	    
	    setupView()
	    setupBinding()
	}

}

// MARK: - Private / Setup

private extension LoadingController {

	func setupView() {
		contentView.alpha = 0.0
	}

	func setupBinding() {
	    let input = LoadingViewModel.Input(
			willAppearTrigger: rx.viewWillAppear.take(1).asDriverOnErrorDoNothing(),
			contentIsHidden: contentIsHiddenRelay.asDriverOnErrorDoNothing()
		)

	    let output = viewModel.transform(input: input)
		
		output.isContentHidden.drive(rx.isContentHidden).disposed(by: disposeBag)
		output.tools.drive().disposed(by: disposeBag)
	}
	
}

// MARK: - Reactive

extension Reactive where Base: LoadingController {

	private enum Constant {
		static var contentAppearingDuration: TimeInterval { 1 }
	}

	var isContentHidden: Binder<Bool> {
		Binder(base) { controller, isContentHidden in
			UIView.animate(
				withDuration: Constant.contentAppearingDuration,
				animations: {
					controller.contentView.alpha = isContentHidden ? 0 : 1
				},
				completion: { _ in
					controller.contentIsHiddenRelay.accept(isContentHidden)
				}
			)
		}
	}

}
