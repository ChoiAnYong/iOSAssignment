//
//  LoginSuccessViewModel.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import Foundation

import RxSwift
import RxCocoa

final class LoginSuccessViewModel: ViewModelType {
    private let userUseCase: UserUseCaseProtocol
    
    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
    
    struct Input {
        let logoutTap: Observable<Void>
        let withdrawalTap: Observable<Void>
    }
    
    struct Output {
        let welcomeText: Driver<String>
        let logoutResult: Signal<Void>
        let withdrawalResult: Signal<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let userInfo = userUseCase.getUserInfo()
        
        let welcomeText = Observable.just("\(userInfo.nickname) 님 환영합니다.")
                    .asDriver(onErrorJustReturn: "환영합니다.")
        
        let logoutResult = input.logoutTap
            .map { _ in }
            .asSignal(onErrorSignalWith: .empty())
        
        let withdrawalResult = input.withdrawalTap
            .map { [weak self] in
                guard let self = self else { return false }
                return self.userUseCase.withDraw(id: userInfo.id)
            }
            .asSignal(onErrorJustReturn: false)
        
        return Output(
            welcomeText: welcomeText,
            logoutResult: logoutResult,
            withdrawalResult: withdrawalResult
        )
    }
}
