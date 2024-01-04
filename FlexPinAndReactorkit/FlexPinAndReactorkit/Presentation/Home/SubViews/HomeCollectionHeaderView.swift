//
//  HomeCollectionHeaderView.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/17/23.
//

import UIKit
import FlexLayout
import PinLayout

class HomeCollectionHeaderView: UICollectionReusableView {
    static let identifier = "HomeCollectionHeaderView"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented xib init")
    }
    
    private func addViews() {
        
    }
    
    private func setLayouts() {
        
    }
    
}
