//
//  ViewController.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import UIKit
import RxSwift

class ViewController<ViewModel: ViewModelType>: UIViewController {
	
	public let disposeBag = DisposeBag()
	public var viewModel: ViewModel!
	
	init(viewModel: ViewModel, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
		self.viewModel = viewModel
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	@available(swift, deprecated: 4.0, obsoleted: 4.0, message: "Use init(viewModel:)")
	init() { fatalError("Use init(viewModel:)") }
	
	@available(swift, deprecated: 4.0, obsoleted: 4.0, message: "Use init(viewModel:)")
	required init?(coder: NSCoder) { fatalError("Use init(viewModel:)") }
	
	private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

}
