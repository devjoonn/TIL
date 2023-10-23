//
//  UIImageView+Utils.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/23/23.
//

import UIKit

extension UIImageView {
    func setImageFromData(data: Data?) {
        if let data = data {
            if let image = UIImage(data: data) {
                self.image = image
            } else {
                print("이미지 변환 실패")
            }
        }
    }
    
    func addDefaultImage() {
        image = UIImage(named: "default")
    }
}
