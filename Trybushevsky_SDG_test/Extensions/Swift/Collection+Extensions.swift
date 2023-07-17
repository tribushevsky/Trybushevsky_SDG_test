//
//  Collection+Extensions.swift
//  Trybushevsky_SDG_test
//
//  Created by VLDMR on 16.07.23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
	
	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}

}
