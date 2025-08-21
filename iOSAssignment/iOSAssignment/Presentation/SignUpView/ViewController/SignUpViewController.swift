//
//  SignUpViewController.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import RxSwift

final class SignUpViewController: UIViewController {
    private let rootView = SignUpView()
    private let viewModel: SignUpViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        setDelegate()
        bindViewModel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension SignUpViewController {
    func setDelegate() {
        [
            rootView.idTextField,
            rootView.passwordTextField,
            rootView.passwordCheckTextField
        ].forEach {
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
            let input = SignUpViewModel.Input(
                idText: rootView.idTextField.rx.text.asObservable(),
                passwordText: rootView.passwordTextField.rx.text.asObservable(),
                passwordCheckText: rootView.passwordCheckTextField.rx.text.asObservable(),
                nicknameText: rootView.nicknameTextField.rx.text.asObservable(),
                signUpTap: rootView.signUpButton.rx.tap.asObservable()
            )
            
            let output = viewModel.transform(input: input, disposeBag: disposeBag)
            
            output.isSignUpEnabled
                .drive(rootView.signUpButton.rx.isEnabled)
                .disposed(by: disposeBag)
            
            output.signUpResult
                .emit(onNext: { [weak self] success in
                    guard let self else { return }
                    if success {
                        let alert = UIAlertController(
                            title: "회원가입 성공",
                            message: "메인 화면으로 이동합니다",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                            self.navigationController?.setViewControllers(
                                [DIContainer.shared.makeLoginSuccessViewController()],
                                animated: false
                            )
                        }))
                        self.present(alert, animated: true)
                    } else {
                        let alert = UIAlertController(
                            title: "회원가입 실패",
                            message: "아이디가 이미 존재합니다",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alert, animated: true)
                    }
                })
                .disposed(by: disposeBag)
        }

}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case rootView.idTextField:
            rootView.passwordTextField.becomeFirstResponder()
        case rootView.passwordTextField:
            rootView.passwordCheckTextField.becomeFirstResponder()
        case rootView.passwordCheckTextField:
            rootView.nicknameTextField.becomeFirstResponder()
        case rootView.nicknameTextField:
            rootView.nicknameTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
