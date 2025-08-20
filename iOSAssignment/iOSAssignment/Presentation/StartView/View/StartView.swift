//
//  StartView.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import SnapKit
import Then

final class StartView: UIView, BaseViewProtocol {
    let startButton = CustomButton(title: "시작하기", conerRadius: 18, height: 50)
    
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
    }
    
    func setUI() {
        self.addSubview(startButton)
    }
    
    func setLayout() {
        startButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
    }
}
