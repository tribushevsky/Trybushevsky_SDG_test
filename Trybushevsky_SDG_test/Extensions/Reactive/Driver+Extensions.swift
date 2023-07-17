//
//  Driver+Extensions.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 16.07.23.
//

import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
	
	func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
		return map { _ in }
	}

}

extension Driver {

	public func take(_ count: Int) -> Driver<Element> {
		self.asObservable().take(count).asDriverOnErrorDoNothing()
	}

}

extension Driver where Element: OptionalType {
	
	func unwrappedNever() -> Driver<Element.Wrapped> {
		flatMap { value in
			guard let value = value.asOptional else {
				return Driver.never()
			}
			
			return Driver.just(value)
		}
	}

}

