//
//  LoginFormView.swift
//  MoviesDB
//
//  Created by Denis Silko on 22.08.2024.
//

import SwiftUI

struct LoginFormView: View {
    @Binding var username: String
    @Binding var password: String

    let loginAction: Command
    let enterAsGuestAction: Command
    let signUpAction: Command
    let isLoginDisabled: Bool
    
    var body: some View {
        VStack {
            title
            textfields
            Spacer()
            buttons
        }
        .padding()
    }
    
    // MARK: - Title
    
    private var title: some View {
        Text("Welcome to the\nMovies DB")
            .titleStyle()
            .padding(.top, Constants.Layout.titleTopPadding)
    }
    
    // MARK: - Textfields
    
    private var textfields: some View {
        VStack(spacing: Constants.Layout.verticalSpacing) {
            Group {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            .textfieldStyle()
        }
    }
    
    // MARK: - Buttons
    
    private var buttons: some View {
        VStack(spacing: Constants.Layout.verticalSpacing) {
            Button(action: enterAsGuestAction, label: {Text("Enter as guest")})
            ButtonView("Log in", isDisabled: isLoginDisabled, action: loginAction)
            ButtonView("Sign Up", action: signUpAction)
        }
    }
}

// MARK: - Equatable

extension LoginFormView: Equatable {
    static func == (lhs: LoginFormView, rhs: LoginFormView) -> Bool {
        lhs.username == rhs.username &&
        lhs.password == rhs.password
    }
}

// MARK: - Preview

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(username: State(initialValue: "adsbc").projectedValue,
                  password: State(initialValue: "113da").projectedValue,
                  loginAction: nop,
                  enterAsGuestAction: nop,
                  signUpAction: nop,
                  isLoginDisabled: true)
    }
}
