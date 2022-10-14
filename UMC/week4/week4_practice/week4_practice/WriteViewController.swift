//
//  WriteViewController.swift
//  week4_practice
//
//  Created by 박현준 on 2022/10/13.
//

import UIKit

class WriteViewController: UIViewController {

    
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentTextfield: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let memoTitle = titleTextfield.text else { return }
        guard let memoContent = contentTextfield.text, memoContent.count > 0 else {
            alert(message: "Please enter a note.")
            return
        }
        
        let newMemo = Memo(title: memoTitle, content: memoContent)
        Memo.dummyMemoList.append(newMemo)
        print("Memo saved")
        dismiss(animated: true)
    }

}

extension UIViewController {
    // 경고창 표시
    func alert (title: String = "Notice", message: String) {
        // alert view
        let alert = UIAlertController(title: title, message: "내용을 입력해주세요.", preferredStyle: .alert)
        // 경고창에 표시되는 버튼
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )// 버튼 누르고 실행할 코드
        alert.addAction(okAction)
        // 경고창을 화면에 표시
        present(alert, animated: true, completion: nil)
        
    }
}
