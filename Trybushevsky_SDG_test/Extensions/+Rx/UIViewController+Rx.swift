//
//  UIViewController+Rx.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

	var viewDidLoad: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewDidLoad)).mapToVoid()
	}

	var viewWillAppear: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewWillAppear(_:))).mapToVoid()
	}
	  
	var viewDidLayoutSubviews: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewDidLayoutSubviews)).mapToVoid()
	}
	  
	var viewDidAppear: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewDidAppear(_:))).mapToVoid()
	}
	  
	var viewWillDisappear: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewWillDisappear(_:))).mapToVoid()
	}
	  
	var viewDidDisappear: Observable<Void> {
		return sentMessage(#selector(UIViewController.viewDidDisappear(_:))).mapToVoid()
	}

	func present(_ viewController: UIViewController, animated: Bool) -> Observable<Void> {
		guard base.viewIfLoaded?.window == nil else {
			base.present(viewController, animated: animated)
			return .just(())
		}
		return viewDidLoad.take(1).map { _ in }.do(onSubscribed: { () in
			self.base.present(viewController, animated: animated)
		})
	}

}
