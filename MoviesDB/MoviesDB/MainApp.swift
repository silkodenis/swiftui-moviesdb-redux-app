//
//  MainApp.swift
//  MoviesDB
//
//  Created by Denis Silko on 07.08.2024.
//

import SwiftUI
import Core

@main
struct MainApp: App {
    private let 💉 = AppConfigurator()
    @StateObject private var store: AppStore
    
    init() {
        let initialStore = AppStore(initial: AppState(), 
                                    feedbacks: 💉.feedbacks) { state, action in
            print("🧬 Reduce -->", String(describing: type(of: action)))
            //print("🧬 Reduce -->", action)
            state.reduce(action)
        }
        
        self._store = StateObject(wrappedValue: initialStore)
    }
    
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                RootView(.login)
            }
            .onAppear() {
                store.dispatch(action: UpdateUsername("dssds"))
                store.dispatch(action: UpdatePassword("PjbAeCJeA.U5sEg"))
            }
        }
    }
}
