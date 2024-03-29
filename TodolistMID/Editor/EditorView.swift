//
//  TodoEditorView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 29.01.2022.
//

// swiftlint:disable multiple_closures_with_trailing_closure

import ComposableArchitecture
import SwiftUI

struct EditorView: View {

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    let store: StoreOf<Editor>

    init(store: StoreOf<Editor>, initialItem: TodoItem?) {
        self.store = store
        ViewStore(store).send(Editor.Action.initEditor(item: initialItem))
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                TextEditor(text: viewStore.binding(get: { $0.item.text }, send: { .editorTextChanged(text: $0) }))
                    .cornerRadius(6)
                    .frame(height: 120)
                    .padding(.init(top: 17, leading: 24, bottom: 16, trailing: 24))
                VStack {
                    VStack {
                        HStack {
                            Text("Важность")
                            Spacer().frame(maxWidth: .infinity)
                            Picker("Важность", selection: viewStore.binding(
                                get: { state in
                                    mapPriorityToString(state.item.priority)
                                },
                                send: { value in
                                    .editorPriorityChanged(priority: mapStringToPriority(value))
                                }
                            )) {
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
                                if viewStore.state.item.deadline != nil {
                                    Button(
                                        action: {
                                            viewStore.send(.toggleDeadlinePickerVisibility)
                                        },
                                        label: {
                                            Text(viewStore.state.item.deadline?.formattedDate ?? "")
                                                .font(.system(size: 14))
                                        }
                                    )
                                }
                            }
                            Spacer()
                            Toggle(
                                "",
                                isOn: viewStore.binding(
                                    get: { $0.item.deadline != nil },
                                    send: .editorDeadlineChanged(
                                        deadline: viewStore.state.item.deadline == nil ? Date() : nil
                                    )
                                )
                            )
                        }
                    }
                    .padding(.init(top: 17, leading: 24, bottom: 16, trailing: 24))
                    .background(.white)
                    .cornerRadius(16)

                    if !viewStore.state.isDeadlinePickerHidden {
                        DatePicker(
                            "",
                            selection: viewStore.binding(
                                get: { $0.item.deadline ?? Date(timeIntervalSince1970: 0)},
                                send: { .editorDeadlineChanged(deadline: $0) }
                            ),
                            displayedComponents: [.date]
                        )
                        .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }

                    HStack {
                        Spacer()
                        Button(
                            action: {
                                viewStore.send(.editorItemDeleted)
                            },
                            label: {
                                Text("Удалить")
                                    .foregroundColor(viewStore.state.canItemBeRemoved ? Color.red : Color.gray)
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
                        viewStore.send(.close)
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Отменить")
                    }
                ),
                trailing: Button(
                    action: {
                        viewStore.send(.editorItemSaved)
                    },
                    label: {
                        Text("Сохранить")
                            .foregroundColor(viewStore.state.canItemBeSaved ? Color.blue : Color.gray)
                    }
                )
            )
            .background(Color(red: 0.97, green: 0.97, blue: 0.95))
            .pickerStyle(.segmented)
            .datePickerStyle(.graphical)
        }
    }
}

private func mapStringToPriority(_ str: String) -> TodoItemPriority {
    switch str {
    case "↓":
        return .low
    case "!!":
        return .high
    default:
        return .normal
    }
}

private func mapPriorityToString(_ priority: TodoItemPriority) -> String {
    switch priority {
    case .low:
        return "↓"
    case .high:
        return "!!"
    default:
        return "нет"
    }
}
