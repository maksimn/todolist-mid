//
//  SceneDelegate.swift
//  ReTodoList
//
//  Created by Maksim Ivanov on 09.08.2022.
//

import ComposableArchitecture
import SwiftUI
import UIKit

struct Empty { }

private let initialState = MainTodoList.State(
    items: [],
    completedItemCount: 0,
    areCompleteItemsVisible: false,
    editor: Editor.empty()
)

private let reducer = Reducer<MainTodoList.State, MainTodoList.Action, Empty>.combine(
     AnyReducer { _ in
         Editor()
     }
     .pullback(
         state: \.editor,
         action: /MainTodoList.Action.editor,
         environment: { $0 }
     ),
     AnyReducer { _ in
         MainTodoList()
     }
).debug()

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let contentView = MainTodoListView(
            store: Store(
                initialState: initialState,
                reducer: reducer,
                environment: Empty()
            )
        )

        window = UIWindow(windowScene: windowScene)

        window?.rootViewController = UIHostingController(rootView: contentView)
        window?.makeKeyAndVisible()
    }
}
