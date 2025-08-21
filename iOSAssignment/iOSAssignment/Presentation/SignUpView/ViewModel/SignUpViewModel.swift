//
//  SignUpViewModel.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import Foundation

import RxSwift
import RxCocoa

final class SignUpViewModel: ViewModelType {
    private let userUseCase: UserUseCaseProtocol
    
    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
    
    struct Input {
        let idText: Observable<String?>
        let passwordText: Observable<String?>
        let passwordCheckText: Observable<String?>
        let nicknameText: Observable<String?>
        let signUpTap: Observable<Void>
    }
    
    struct Output {
        let isSignUpEnabled: Driver<Bool>
        let signUpResult: Signal<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let idValid = input.idText
            .map { Self.validateEmail($0 ?? "") }
        
        let passwordValid = input.passwordText
            .map { Self.validatePassword($0 ?? "") }
        
        let passwordMatch = Observable
            .combineLatest(input.passwordText, input.passwordCheckText)
            .map { ($0 ?? "") == ($1 ?? "") && !($0 ?? "").isEmpty }
        
        let nicknameValid = input.nicknameText
            .map { !($0 ?? "").isEmpty }
        
        let allValid = Observable
            .combineLatest(idValid, passwordValid, passwordMatch, nicknameValid) {
                $0 && $1 && $2 && $3
            }
            .share(replay: 1)
        
        let signUpResult = input.signUpTap
            .withLatestFrom(
                Observable.combineLatest(input.idText, input.passwordText, input.nicknameText)
            )
            .flatMapLatest { [self] (id, pw, nick) -> Observable<Bool> in
                guard let id = id, let pw = pw, let nick = nick else {
                    return .just(false)
                }
                
                if self.userUseCase.checkDuplicate(id: id) {
                    return .just(false)
                } else {
                    let result = userUseCase.login(id: id, password: pw, nickname: nick)
                    return .just(result)
                }
            }
            .asSignal(onErrorJustReturn: false)
        
        return Output(
            isSignUpEnabled: allValid.asDriver(onErrorJustReturn: false),
            signUpResult: signUpResult
        )
    }
}

private extension SignUpViewModel {
    static func validateEmail(_ email: String) -> Bool {
        // 기본 이메일 형식 확인
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        guard NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) else {
            return false
        }
        
        // @ 앞부분만 규칙 체크
        guard let prefix = email.split(separator: "@").first else { return false }
        let prefixStr = String(prefix)
        
        // 6~20자
        guard (6...20).contains(prefixStr.count) else { return false }
        
        // 소문자+숫자만
        guard prefixStr.range(of: "^[a-z][a-z0-9]{5,19}$", options: .regularExpression) != nil else {
            return false
        }
        
        return true
    }
    
    static func validatePassword(_ pw: String) -> Bool {
        return pw.count >= 8
    }
}
