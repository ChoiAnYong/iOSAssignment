//
//  UIView+.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
