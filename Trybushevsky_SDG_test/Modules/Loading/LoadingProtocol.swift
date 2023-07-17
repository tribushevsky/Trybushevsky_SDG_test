//
//  LoadingProtocol.swift
//  WaterTracke
//
//  Created by vldmr on 16/07/2023.
//  Copyright 2023 VLDMR. All rights reserved.
//

import RxSwift
import RxCocoa

protocol LoadingContext {
    
	var finishLoading: Observable<Void> { get }
	
}

protocol LoadingUseCase {
    
}

protocol LoadingNavigator: Navigator<Void> {

}
