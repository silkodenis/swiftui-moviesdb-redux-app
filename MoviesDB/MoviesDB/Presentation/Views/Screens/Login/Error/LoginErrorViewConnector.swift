//
//  LoginErrorViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 27.08.2024.
//

import SwiftUI
import Core

struct LoginErrorViewConnector: ViewConnector {
    func map(graph: Graph) -> some View {
        LoginErrorView(status: graph.loginFlow.errorStatus,
                       retryAction: graph.loginFlow.retry)
    }
}

fileprivate extension LoginFlowNode {
    var errorStatus: LoginErrorView.Status {
        switch status {
        case .invalidCredentials: .invalidCredentials
        default: .unknown
        }
    }
}
