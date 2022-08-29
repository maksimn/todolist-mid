//
//  TodoEditorView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 29.01.2022.
//

import SwiftUI

struct EditorView: View {

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    @State
    var text: String = ""

    @State
    var priority: String = "нет"

    @State
    var isDeadineSwitchOn: Bool = true

    @State
    var deadline: Date = Date()

    var body: some View {
        ScrollView {
            TextEditor(text: $text)
                .cornerRadius(6)
                .frame(height: 120)
                .padding(.init(top: 17, leading: 24, bottom: 16, trailing: 24))
            VStack {
                VStack {
                    HStack {
                        Text("Важность")
                        Spacer().frame(maxWidth: .infinity)
                        Picker("Важность", selection: $priority) {
                            ForEach(["↓", "нет", "!!"], id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Divider()
                        .padding(.init(top: 4, leading: -24, bottom: 4, trailing: -24))
                    HStack {
                        VStack {
                            Text("Сделать до")
                            Button(
                                action: {},
                                label: {
                                    Text("22 Янв 2019")
                                        .font(.system(size: 14))
                                }
                            )
                        }
                        Spacer()
                        Toggle("", isOn: $isDeadineSwitchOn)
                    }
                }
                .padding(.init(top: 17, leading: 24, bottom: 16, trailing: 24))
                .background(.white)
                .cornerRadius(16)
                DatePicker(
                    "",
                    selection: $deadline,
                    displayedComponents: [.date]
                )
                .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Spacer()
                    Button(
                        action: {},
                        label: {
                            Text("Удалить")
                                .foregroundColor(.red)
                        }
                    )
                    .padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    Spacer()
                }
                .background(.white)
                .cornerRadius(16)
            }
            .padding(.init(top: 0, leading: 24, bottom: 16, trailing: 24))
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Дело"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: {
                    self.presentationMode.wrappedValue.dismiss()
                },
                label: {
                    Text("Отменить")
                }
            ),
            trailing: Button(
                action: {},
                label: {
                    Text("Сохранить")
                        .foregroundColor(.gray)
                }
            )
        )
        .background(Color(red: 0.97, green: 0.97, blue: 0.95))
        .pickerStyle(.segmented)
        .datePickerStyle(.graphical)
    }
}

struct EditorView_Previews: PreviewProvider {

    static var previews: some View {
        EditorView()
    }
}
