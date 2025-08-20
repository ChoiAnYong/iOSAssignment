//
//  ViewModelType.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output
}
