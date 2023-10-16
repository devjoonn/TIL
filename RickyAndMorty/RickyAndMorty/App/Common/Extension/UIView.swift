//
//  UIView.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//

import UIKit

extension UIView {
    func setConstraints(
        top: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        pTop: CGFloat = CGFloat.zero,
        pRight: CGFloat = CGFloat.zero,
        pBottom: CGFloat = CGFloat.zero,
        pLeft: CGFloat = CGFloat.zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: pTop).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -pRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -pBottom).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
        }
    }
    
    func fillSuperView(widthPadding: CGFloat = .zero) {
        guard let superview = self.superview else { return }
        setConstraints(top: superview.topAnchor, right: superview.rightAnchor, bottom: superview.bottomAnchor, left: superview.leftAnchor, 
                       pTop: widthPadding, pRight: widthPadding, pBottom: widthPadding, pLeft: widthPadding)
    }
    
    func setHeightConstraint(with height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidthConstraint(with width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
