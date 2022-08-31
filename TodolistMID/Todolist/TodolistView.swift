//
//  TodolistView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.01.2022.
//

import ComposableArchitecture
import SwiftUI

let store = Store(initialState: nil, reducer: editorReducer.debug(), environment: EditorEnvironment())
let viewStore = ViewStore(store)

struct NavigationLazyView<Content: View>: View {

    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct TodolistView: View {

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(maxHeight: .infinity)
                NavigationLink(
                    destination: NavigationLazyView(EditorView(store: store))
                ) {
                    Image("icon-plus")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.bottom, 24)
                }
                .navigationTitle("Мои дела")
            }.frame(maxHeight: .infinity)
        }
    }
}
