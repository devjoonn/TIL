//
//  NetworkService.swift
//  bluetoothAndArduino
//
//  Created by 박현준 on 10/28/23.
//

import Foundation
import FirebaseDatabase

//MARK: - Database Refs
let DB_REF = Database.database().reference()

struct NetworkService {
    static let networkService = NetworkService()
    
    func save(beat: String, breath: String) {
        
        let values = ["beatCount": beat,
                      "breathCount": breath] as [String : Any]
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        if let year = components.year, let month = components.month, let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
            let formattedMonth = String(format: "%02d", month)
            let formattedDay = String(format: "%02d", day)
            let formattedHour = String(format: "%02d", hour)
            let formattedMinute = String(format: "%02d", minute)
            let formattedSecond = String(format: "%02d", second)
            
            DB_REF.child("\(year)\(formattedMonth)\(formattedDay)_\(formattedHour)\(formattedMinute)\(formattedSecond)").updateChildValues(values)
            print("\(year)년 \(formattedMonth)월 \(formattedDay)일 \(formattedHour)시 \(formattedMinute)분 \(formattedSecond)초 데이터 저장 완료.")
        }
    }
}
