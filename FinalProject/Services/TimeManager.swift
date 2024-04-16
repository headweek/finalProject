//
//  TimeManager.swift
//  FinalProject
//
//  Created by apple on 15.04.2024.
//

import Foundation

final class TimeManager {
    private init() {}
    
    static func getStringDate(_ date: Date) -> String {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            return formater.string(from: date)
    }
    
}
