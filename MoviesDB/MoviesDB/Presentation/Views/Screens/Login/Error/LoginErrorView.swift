//
//  LoginErrorView.swift
//  MoviesDB
//
//  Created by Denis Silko on 26.08.2024.
//

import SwiftUI

struct LoginErrorView: View {
    let status: Status
    let retryAction: Command
    
    var body: some View {
        ErrorView(description: status.rawValue,
                  buttonTitle: "Retry",
                  buttonAction: retryAction)
    }
    
    enum Status: String {
        case unknown = "Unknown error."
        
        case invalidCredentials = """
                        Invalid credentials.

                        You do not have permissions
                        to access the service.
                        """
    }
}

extension LoginErrorView: Equatable {
    static func == (lhs: LoginErrorView, rhs: LoginErrorView) -> Bool {
        lhs.status == rhs.status
    }
}

// MARK: - Preview

struct LoginErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LoginErrorView(status: .invalidCredentials,
                       retryAction: nop)
    }
}
