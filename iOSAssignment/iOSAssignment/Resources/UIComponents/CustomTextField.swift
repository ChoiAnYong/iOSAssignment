//
//  CustomTextField.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

import Then
import SnapKit

final class CustomTextField: UITextField {
    init(placeHolder: String, height: CGFloat = 40) {
        super.init(frame: .zero)
        
        setStyle(placeHolder: placeHolder)
        setLayout(height: height)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomTextField {
    func setStyle(placeHolder: String) {
        setText(
            placeholder: placeHolder,
            textColor: .black,
            backgroundColor: .white,
            placeholderColor: .systemGray3
        )
        addPadding(left: 18)
        setLayer(borderWidth: 1, borderColor: .systemGray3, cornerRadius: 8)
        setAutoType()
    }
    
    func setLayout(height: CGFloat) {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    func setAddTarget() {
        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
}


extension CustomTextField {
    @objc
    private func editingDidBegin() {
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc
    private func editingDidEnd() {
        self.layer.borderColor = UIColor.systemGray3.cgColor
    }
}
