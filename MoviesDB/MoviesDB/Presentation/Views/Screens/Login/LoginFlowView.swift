//
//  LoginFlowView.swift
//  MoviesDB
//
//  Created by Denis Silko on 27.08.2024.
//

import SwiftUI

struct LoginFlowView<L: View, P: View, E: View>: View {
    let flow: Flow
    
    let login: () -> L
    let progress: () -> P
    let error: () -> E
    
    var body: some View {
        switch flow {
        case .login: login()
        case .progress: progress()
        case .error: error()
        }
    }
    
    enum Flow {
        case login
        case progress
        case error
    }
}

#Preview {
    LoginFlowView(flow: .login,
                  login: {LoginFormView_Previews.previews},
                  progress: {LoginProgressView_Previews.previews},
                  error: {LoginErrorView_Previews.previews})
}
