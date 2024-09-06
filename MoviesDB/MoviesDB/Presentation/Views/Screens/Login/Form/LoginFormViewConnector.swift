//
//  LoginFormViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 22.08.2024.
//

import SwiftUI
import Core

struct LoginFormViewConnector: ViewConnector {
    @Environment(\.openURL) private var openURL
    
    func map(graph: Graph) -> some View {
        LoginFormView(username: Binding(get: {graph.loginForm.username},
                                        set: {graph.loginForm.username = $0}),
                      password: Binding(get: {graph.loginForm.password},
                                        set: {graph.loginForm.password = $0}),
                      loginAction: graph.loginFlow.login,
                      enterAsGuestAction: graph.loginFlow.enterAsGuest,
                      signUpAction: {signUp(url: graph.signUp.url)},
                      isLoginDisabled: !graph.loginForm.isValidCredentials)
    }
    
    private func signUp(url: URL?) {
        guard let url else { return }
        openURL(url)
    }
}
