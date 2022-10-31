//
//  ViewController.swift
//  week6
//
//  Created by 박현준 on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    var colorList: [UIColor] = [
        .blue,
        .brown,
        .systemPink,
        .cyan,
        .darkText,
        .gray,
        .lightText,
        .red,
        .yellow,
        .green
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        threadTest()
    }
    
    func threadTest() {
        DispatchQueue.global().async { // 백그라운드에서 실행되는 작업
            for color in self.colorList {
                DispatchQueue.main.sync { //메인에서 실행되는 작업 - UI 업데이트
                    self.firstView.backgroundColor = color
                }
                sleep(1)
            }
        }
        
        DispatchQueue.global().async {
            for color in self.colorList.reversed() {
                DispatchQueue.main.sync {
                    self.secondView.backgroundColor = color
                }
                sleep(1)
            }
        }
    }
    
}
