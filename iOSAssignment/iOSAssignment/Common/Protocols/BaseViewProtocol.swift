//
//  BaseViewProtocol.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

protocol BaseViewProtocol {
    func setUpView()
    func setStyle()
    func setUI()
    func setLayout()
}

extension BaseViewProtocol {
    func setUpView() {
        setStyle()
        setUI()
        setLayout()
    }
}
