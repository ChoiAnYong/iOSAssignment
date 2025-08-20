//
//  UITextField+.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

extension UITextField {
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
    
    func setText(
        placeholder: String,
        textColor: UIColor,
        backgroundColor: UIColor,
        placeholderColor: UIColor
    ) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor,
                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ]
        )
        self.attributedText = NSAttributedString(
            string: "",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ]
        )
    }
    
    func setAutoType(
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no
    ) {
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
    }
    
    func setLayer(borderWidth: CGFloat = 0, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
}
