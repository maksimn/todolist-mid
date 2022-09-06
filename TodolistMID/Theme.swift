//
//  Theme.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 06.09.2022.
//

import SwiftUI

struct Theme {

    let lightTextColor: Color

    private init(lightTextColor: Color) {
        self.lightTextColor = lightTextColor
    }

    static let data = Theme(lightTextColor: Color(red: 0.7, green: 0.7, blue: 0.7))
}
