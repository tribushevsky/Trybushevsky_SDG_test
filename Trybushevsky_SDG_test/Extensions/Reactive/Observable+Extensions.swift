//
//  Observable+Extensions.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 15.07.23.
//

import RxSwift
import RxCocoa

extension ObservableType {
  
	func asDriverOnErrorJustComplete() -> Driver<Element> {
		return asDriver { error in
			return Driver.empty()
		}
	}
  
	func asDriverOnErrorDoNothing() -> Driver<Element> {
		return asDriver { error in
			return Driver.never()
		}
	}
  
	func mapToVoid() -> Observable<Void> {
		return map { _ in }
	}
  
	func asBoolDriver() -> Driver<Bool> {
		return map { _ in true}.asDriver(onErrorJustReturn: false)
	}
  
	public static func wrapError(_ error: Error) -> Observable<Element> {
		return Observable.error(error)
	}
  
	public static func fatalEmpty(msg: String) -> Observable<Element> {
		#if DEBUG
		fatalError(msg)
		#else
		return Observable.empty()
		#endif
	}
	
	public static func fatalNever(msg: String) -> Observable<Element> {
		#if DEBUG
		fatalError(msg)
		#else
		return Observable.never()
		#endif
	}

}

extension ObservableType where Element: OptionalType {
	
	func unwrappedNever() -> Observable<Element.Wrapped> {
		flatMap { value -> Observable<Element.Wrapped> in
			guard let value = value.asOptional else {
				return Observable.never()
			}
			
			return Observable.just(value)
		}
	}

}

protocol OptionalType {
	
	associatedtype Wrapped
	var asOptional:  Wrapped? { get }

}

extension Optional: OptionalType {
	
	var asOptional: Wrapped? { return self }

}

