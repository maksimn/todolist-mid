//
//  Date+Core.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.08.2022.
//

import Foundation

extension Date {

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"

        return dateFormatter.string(from: self)
    }

    var integer: Int {
        Int(timeIntervalSince1970)
    }
}
