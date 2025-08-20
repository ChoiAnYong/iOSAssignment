//
//  UIStackView+.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

extension UIStackView {
    func addArragedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
