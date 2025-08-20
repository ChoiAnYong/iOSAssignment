//
//  CustomButton.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import Then
import SnapKit

final class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.layer.borderColor = isHighlighted ? UIColor.systemGray2.cgColor : UIColor.black.cgColor
            self.backgroundColor  = isHighlighted ? UIColor.systemGray6 : UIColor.white
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.layer.borderColor = UIColor.black.cgColor
                self.backgroundColor  = UIColor.white
                self.setTitleColor(.black, for: .normal)
            } else {
                self.layer.borderColor = UIColor.systemGray2.cgColor
                self.backgroundColor  = UIColor.systemGray6
                self.setTitleColor(.systemGray3, for: .normal)
            }
        }
    }
    
    init(
        title: String,
        conerRadius: CGFloat = 15 ,
        height: CGFloat = 48
    ) {
        super.init(frame: .zero)
        
        setStyle(title: title, cornerRadius: conerRadius)
        setLayout(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomButton {
    func setStyle(title: String, cornerRadius: CGFloat) {
        self.do {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = cornerRadius
            $0.layer.borderColor = UIColor.black.cgColor
            $0.backgroundColor = .white
        }
    }
    
    func setLayout(height: CGFloat) {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
