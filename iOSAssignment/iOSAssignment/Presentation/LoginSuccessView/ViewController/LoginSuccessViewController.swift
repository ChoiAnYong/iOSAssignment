//
//  LoginSuccessViewController.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import RxSwift

final class LoginSuccessViewController: UIViewController {
    private let rootView = LoginSuccessView()
    private let viewModel: LoginSuccessViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginSuccessViewModel) {
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
        super.viewDidLoad()
        
        bindViewModel()
    }
}

private extension LoginSuccessViewController {
    func bindViewModel() {
        let input  = LoginSuccessViewModel.Input(
            logoutTap: rootView.logoutButton.rx.tap.asObservable(),
            withdrawalTap: rootView.withdrawalButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.welcomeText
            .drive(rootView.welcomeLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.logoutResult
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.navigationController?.setViewControllers(
                    [DIContainer.shared.makeStartViewController()],
                    animated: false
                )
            })
            .disposed(by: disposeBag)
        
        output.withdrawalResult
            .emit(onNext: { [weak self] success in
                guard let self else { return }
                if success {
                    self.navigationController?.setViewControllers(
                        [DIContainer.shared.makeStartViewController()],
                        animated: false
                    )
                } else {
                    let alert = UIAlertController(
                        title: "오류",
                        message: "회원탈퇴에 실패했습니다.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
