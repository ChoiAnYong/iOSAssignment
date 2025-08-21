//
//  StartViewController.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/19/25.
//

import UIKit

import RxSwift

final class StartViewController: UIViewController {
    private let rootView = StartView()
    private let viewModel: StartViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: StartViewModel) {
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

private extension StartViewController {
    func bindViewModel() {
        let input = StartViewModel.Input(
            startTrigger: rootView.startButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.startResult
            .emit(onNext: { [weak self] isLogined in
                guard let self else { return }
                if isLogined {
                    self.navigationController?.setViewControllers(
                        [DIContainer.shared.makeLoginSuccessViewController()],
                        animated: false
                    )
                } else {
                    self.navigationController?.pushViewController(
                        DIContainer.shared.makeSignUpViewController(),
                        animated: true
                    )
                }
            })
            .disposed(by: disposeBag)
    }
}

