//
//  SignUpView.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import SnapKit
import Then

final class SignUpView: UIView, BaseViewProtocol {
    private let idTitleLabel = UILabel()
    private let passwordTitleLabel = UILabel()
    private let passwordCheckTitleLabel = UILabel()
    private let nicknameTitleLabel = UILabel()
    
    let signUpButton = CustomButton(title: "회원가입")
    let idTextField = CustomTextField(placeHolder: "이메일을 입력해주세요")
    let passwordTextField = CustomTextField(placeHolder: "비밀번호를 입력해주세요")
    let passwordCheckTextField = CustomTextField(placeHolder: "비밀번호를 다시 입력해주세요")
    let nicknameTextField = CustomTextField(placeHolder: "닉네임을 입력해주세요")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.do {
            $0.backgroundColor = .white
        }
        
        idTitleLabel.do {
            $0.text = "아이디"
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .black
        }
        
        passwordTitleLabel.do {
            $0.text = "비밀번호"
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .black
        }
        
        passwordCheckTitleLabel.do {
            $0.text = "비밀번호 확인"
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .black
        }
        
        nicknameTitleLabel.do {
            $0.text = "닉네임"
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .black
        }
        
        idTextField.do {
            $0.keyboardType = .emailAddress
        }
        
        passwordTextField.do {
            $0.keyboardType = .default
            $0.isSecureTextEntry = true
        }
        
        passwordCheckTextField.do {
            $0.keyboardType = .default
            $0.isSecureTextEntry = true
        }
        
        signUpButton.do {
            $0.isEnabled = true
        }
    }
    
    func setUI() {
        self.addSubViews(
            idTitleLabel,
            idTextField,
            passwordTitleLabel,
            passwordTextField,
            passwordCheckTitleLabel,
            passwordCheckTextField,
            nicknameTitleLabel,
            nicknameTextField,
            signUpButton
        )
    }
    
    func setLayout() {
        idTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idTitleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        passwordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        passwordCheckTitleLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTitleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        nicknameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTitleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(50)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
