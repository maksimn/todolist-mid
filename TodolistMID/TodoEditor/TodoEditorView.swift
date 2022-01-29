//
//  TodoEditorView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 29.01.2022.
//

import SwiftUI

struct TodoEditorView: View {

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    @State var text: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .cornerRadius(6)
                .frame(height: 120)
                .padding(.init(top: 17, leading: 24, bottom: 16, trailing: 24))
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Дело"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: { self.presentationMode.wrappedValue.dismiss() },
                label: {
                    Text("Отменить")
                }
            ),
            trailing: Button(action: {}, label: { Text("Сохранить").foregroundColor(.gray) })
        )
        .background(Color(red: 1.00, green: 0.80, blue: 1.00))
    }
}
