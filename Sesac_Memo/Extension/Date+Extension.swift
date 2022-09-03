//
//  Date+Extension.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/03.
//

import Foundation

extension Date {
    
    func dateToString(dateCase: DateFormatterCase) -> String {
        
        switch dateCase {
        case .today:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a HH:mm"
            dateFormatter.amSymbol = "오전"
            dateFormatter.pmSymbol = "오후"
            
            return dateFormatter.string(from: self)
        case .thisWeek:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            return dateFormatter.string(from: self)
        case .other:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. MM. dd a HH:mm"
            dateFormatter.amSymbol = "오전"
            dateFormatter.pmSymbol = "오후"
            
            return dateFormatter.string(from: self)
        }
        
    }
    
    func checkDate() -> String {
        if Calendar.current.dateComponents([.day, .weekOfYear, .year], from: Date()) == Calendar.current.dateComponents([.day, .weekOfYear, .year], from: self) {
            
            return dateToString(dateCase: .today)
            
        } else if Calendar.current.dateComponents([.weekOfYear, .year], from: Date()) == Calendar.current.dateComponents([.weekOfYear, .year], from: self) {
            
            return dateToString(dateCase: .thisWeek)
            
        } else {
            return dateToString(dateCase: .other)
        }
    }
    
}
