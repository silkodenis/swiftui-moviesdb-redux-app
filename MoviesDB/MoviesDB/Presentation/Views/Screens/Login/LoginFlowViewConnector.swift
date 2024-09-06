//
//  LoginFlowViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 27.08.2024.
//

import SwiftUI
import Core

struct LoginFlowViewConnector: ViewConnector {
    @EnvironmentObject var coordinator: Coordinator
    
    func map(graph: Graph) -> some View {
        LoginFlowView(flow: graph.loginFlow.loginFlow,
                      login: {LoginFormViewConnector()},
                      progress: {LoginProgressViewConnector()},
                      error: {LoginErrorViewConnector()})
    }
    
    func feedback(action: any AppAction) {
        switch action {
        case is ReceiveGuestSession, 
             is ReceiveUserSession:
            coordinator.push(.moviesList)
            
        default:
            break
        }
    }
}

fileprivate extension LoginFlowNode {
    var loginFlow: LoginFlowView<LoginFormViewConnector,
                                 LoginProgressViewConnector,
                                 LoginErrorViewConnector>.Flow {
        switch status {
        case .idle: .login
        case .inProgress: .progress
        case .invalidCredentials: .error
        case .success: .progress
        case .failed: .error
        }
    }
}
