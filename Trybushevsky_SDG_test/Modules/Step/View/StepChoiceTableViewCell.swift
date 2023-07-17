//
//  StepChoiceTableViewCell.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 16.07.23.
//

import UIKit

final class StepChoiceTableViewCell: UITableViewCell {
	
	private let containerView: UIView = {
		let view = UIView()
		view.backgroundColor = .lightGray
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		setupView()
	}
	
}

// MARK: - Setup View

extension StepChoiceTableViewCell {
	
	private func setupView() {
		selectionStyle = .none
		contentView.addSubview(containerView)
		containerView.addSubview(titleLabel)

		NSLayoutConstraint.activate(
			[
				containerView.heightAnchor.constraint(equalToConstant: 50),
				containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
				containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
				containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
				containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
				titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
				titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
				titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
				titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10)
			]
		)
	}

}

// MARK: - IBDesignable

@IBDesignable
extension StepChoiceTableViewCell {
	
	var title: String? {
		get { titleLabel.text }
		set { titleLabel.text = newValue }
	}

}
