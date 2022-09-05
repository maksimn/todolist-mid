//
//  NavigationLazyView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 01.09.2022.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {

    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
