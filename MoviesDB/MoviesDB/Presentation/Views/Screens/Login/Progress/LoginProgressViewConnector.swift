//
//  LoginProgressViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 27.08.2024.
//

import SwiftUI
import Core

struct LoginProgressViewConnector: ViewConnector {
    func map(graph: Graph) -> some View {
        LoginProgressView(progress: graph.loginFlow.progress)
    }
}

fileprivate extension LoginFlowNode {
    var progress: LoginProgressView.Progress {
        switch flow {
        case .authenticating: .authenticating
        case .validating: .validating
        case .creatingUserSession: .creatingUserSession
        case .creatingGuestSession: .creatingGuestSession
        case .idle: .idle
        }
    }
}
