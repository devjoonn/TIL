//
//  memo.swift
//  week4_practice
//
//  Created by 박현준 on 2022/10/13.
//

import Foundation

class Memo {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    static var dummyMemoList = [
        Memo(title: "첫번째", content: "테스트"),
        Memo(title: "두번째", content: "안녕"),
        Memo(title: "셀테스트", content: "셀테스트 클릭"),
        Memo(title: "세번째", content: "테스트"),
        Memo(title: "네번쨰", content: "ㅇㅇㅇㅇ"),
        Memo(title: "다섯번째", content: "ㅁㅇㅁㅇ"),
        Memo(title: "여섯번째", content: "ㅂㅈㅂㅈ"),
        Memo(title: "하이하이", content: "ㅎㅇㅎㅇ")
        
    ]
}
