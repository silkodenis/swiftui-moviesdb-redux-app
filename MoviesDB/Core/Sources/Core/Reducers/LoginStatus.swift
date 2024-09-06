public enum LoginStatus {
    case idle
    case inProgress
    case invalidCredentials
    case success
    case failed
    
    internal init() { self = .idle }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
            
        case is Login: self = .inProgress
        case is EnterAsGuest: self = .inProgress
        case is TokenRequestFailed: self = .failed
        case is TokenValidationFailed: self = .failed
        case is SessionRequestFailed: self = .failed
        case is InvalidCredentials: self = .invalidCredentials
        case is ReceiveGuestSession: self = .success
        case is ReceiveUserSession: self = .success
        case is RetryLoginFlow: self = Self()
        case is Logout: self = Self()
            
        default: break
        }
    }
}
