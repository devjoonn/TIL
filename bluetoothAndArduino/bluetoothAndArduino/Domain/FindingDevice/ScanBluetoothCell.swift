//
//  ScanBluetoothCell.swift
//  bluetoothAndArduino
//
//  Created by 박현준 on 10/12/23.
//

import UIKit
import SnapKit

class ScanBluetoothCell: UITableViewCell {

    static let identifier = "ScanBluetoothCell"
    
    var titleLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    private func setUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
    }
    
}
