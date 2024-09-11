public struct LoginForm {
    internal var rawUsername: String = ""
    internal var rawPassword: String = ""
    
    public var credentials: Credentials? {
        guard case let .success(username) = Username.parse(rawUsername),
              case let .success(password) = Password.parse(rawPassword) else {
            return nil
        }
        
        return Credentials(username: username, password: password)
    }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
            
        case let action as UpdateUsername: rawUsername = action.username
        case let action as UpdatePassword: rawPassword = action.password
        case is Logout: self = Self()
        case is RetryLoginFlow: self = Self()
            
        default: break
        }
    }
}
