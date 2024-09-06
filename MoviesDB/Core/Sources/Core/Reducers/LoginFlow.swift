//
//  File.swift
//  
//
//  Created by Denis Silko on 14.08.2024.
//

import Foundation

public enum LoginFlow {
    case idle
    case authenticating
    case validating(Token)
    case creatingUserSession(Token)
    case creatingGuestSession
    
    internal init() { self = .idle }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        
        case is Login: self = .authenticating
        case is EnterAsGuest: self = .creatingGuestSession
        case is RetryLoginFlow: self = Self()
        case is Logout: self = Self()
            
        case let action as ReceiveToken: self = .validating(action.token)
        case let action as TokenValidated: self = .creatingUserSession(action.token)

        default: break
        }
    }
}
