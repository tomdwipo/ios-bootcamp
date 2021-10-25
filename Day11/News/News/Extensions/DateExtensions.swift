//
//  DateExtensions.swift
//  News
//
//  Created by Bayu Yasaputro on 16/10/21.
//

import Foundation

extension Date {
    var defaultDate: Date {
        return Date(timeIntervalSince1970: 0)
    }
    
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
