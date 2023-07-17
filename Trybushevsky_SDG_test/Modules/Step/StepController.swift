//
//  StepController.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import UIKit
import RxSwift
import RxCocoa

final class StepController: ViewController<StepViewModel> {

	@IBOutlet fileprivate weak var contentView: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet fileprivate weak var tableView: UITableView!

	fileprivate var choices: [String] = []

	override func viewDidLoad() {
	    super.viewDidLoad()
	    
	    setupView()
	    setupBinding()
	}

}

// MARK: Constant

extension StepController {

	private enum Constant {
		static var choiceCellIdentifier: String { "choiceCellIdentifier" }
		static var appearingAninationDuration: TimeInterval { 1 }
	}

}

// MARK: - Setup

extension StepController {

	private func setupView() {
		tableView.register(
			StepChoiceTableViewCell.self,
			forCellReuseIdentifier: Constant.choiceCellIdentifier
		)
	}

	private func setupBinding() {
	    let input = StepViewModel.Input(
			willAppearTrigger: rx.viewWillAppear.take(1).asDriverOnErrorDoNothing(),
			selectedChoice: tableView.rx.itemSelected.map { $0.row }.asDriverOnErrorDoNothing()
		)
	    
		let output = viewModel.transform(input: input)
		output.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
		output.choices.drive(rx.choices).disposed(by: disposeBag)
		output.image.drive(imageView.rx.image).disposed(by: disposeBag)
		output.isContentHidden.drive(rx.isContentHidden).disposed(by: disposeBag)
		output.tools.drive().disposed(by: disposeBag)
	}
	
	fileprivate func updateContentView(isHidden: Bool, animated: Bool) {
		let updates = {
			self.contentView.isUserInteractionEnabled = !isHidden
			self.contentView.alpha = isHidden ? 0 : 1
		}

		guard animated else {
			updates()
			return
		}
		
		UIView.animate(withDuration: Constant.appearingAninationDuration) {
			updates()
		}
	}

}

// MARK: - Reactive

extension Reactive where Base: StepController {

	var choices: Binder<[String]> {
		Binder(base) { controller, choices in
			controller.choices = choices
			controller.tableView.reloadData()
		}
	}
	
	var isContentHidden: Binder<(Bool, Bool)> {
		Binder(base) { controller, params in
			controller.updateContentView(isHidden: params.0, animated: params.1)
		}
	}

}

// MARK: - UITableViewDataSource

extension StepController: UITableViewDataSource {
	
	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: Constant.choiceCellIdentifier,
			for: indexPath
		)
		
		if let choiceCell = cell as? StepChoiceTableViewCell {
			choiceCell.title = choices[safe: indexPath.row]
		}
		
		return cell
	}
	
	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		choices.count
	}
	
}
