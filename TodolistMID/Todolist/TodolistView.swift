//
//  TodolistView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.01.2022.
//

import SwiftUI

struct TodolistView: View {

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(maxHeight: .infinity)
                NavigationLink(destination: TodoEditorView()) {
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
