//
//  momo.swift
//  week4_practice
//
//  Created by 박현준 on 2022/10/13.
//

import Foundation

class Memo {
    var content: String
    var date: Date
    
    init(content: String, date: String) {
        self.content = content
        self.date = Date()
    }
    
    static var dummyMemoList = [
        Memo(content: "메모 첫번째", date: "2022.05.02"),
        Memo(content: "컨텐츠 생각중", date: "2022.03.21")
    ]
}

