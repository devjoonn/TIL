//
//  Padding.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/9/23.
//

import UIKit

enum Padding {
    case small
    case medium
    case large
    case custom(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    
    var insets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        case .medium:
            return UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 20)
        case .large:
            return UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        case .custom(let top, let left, let bottom, let right):
            return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    }
}
