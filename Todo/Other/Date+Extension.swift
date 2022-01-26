//
//  Date+Extension.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import Foundation

extension Date {
    
    func simpleString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd,yyyy"
        return dateFormat.string(from: self)
        
    }
}
