//
//  NSDateExtension.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/20/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation

extension Date {
    
    func offsetFrom(date : Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        let seconds = "\(String(describing: difference.second ?? 0)) seconds"
        let minutes = "\(String(describing: difference.minute ?? 0)) minutes"
        let hours = "\(String(describing: difference.hour ?? 0)) hours"
        let days = "\(String(describing: difference.day ?? 0)) days"
        
        if let d = difference.day, d > 0 {
            return days
        }
        if let h = difference.hour, h > 0 {
            return hours
        }
        if let m = difference.minute, m > 0 {
            return minutes
        }
        if let s = difference.second, s > 0 {
            return seconds
        }
        return ""
    }
}
