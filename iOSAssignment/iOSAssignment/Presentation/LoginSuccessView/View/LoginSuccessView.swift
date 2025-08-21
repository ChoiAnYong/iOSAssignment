//
//  LoginSuccessView.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import UIKit

import SnapKit
import Then

final class LoginSuccessView: UIView, BaseViewProtocol {
    let welcomeLabel = UILabel()    
    let logoutButton = CustomButton(title: "로그아웃", conerRadius: 18, height: 50)
    let withdrawalButton = CustomButton(title: "회원탈퇴", conerRadius: 18, height: 50)
    
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
        
        welcomeLabel.do {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
    }
    
    func setUI() {
        self.addSubViews(welcomeLabel, logoutButton, withdrawalButton)
    }
    
    func setLayout() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(-20)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(50)
        }
    }
}
