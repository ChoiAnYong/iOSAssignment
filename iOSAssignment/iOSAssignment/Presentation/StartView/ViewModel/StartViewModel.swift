//
//  StartViewModel.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import Foundation

import RxSwift
import RxCocoa

final class StartViewModel: ViewModelType {
    private let userUseCase: UserUseCaseProtocol
    
    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
    
    struct Input {
        let startTrigger: Observable<Void>
    }
    
    struct Output {
        let startResult: Signal<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let result = input.startTrigger
            .map { [weak self] in
                guard let self = self else { return false }
                return self.userUseCase.isLogined()
            }
            .asSignal(onErrorJustReturn: false)
        
        return Output(startResult: result)
    }
}

