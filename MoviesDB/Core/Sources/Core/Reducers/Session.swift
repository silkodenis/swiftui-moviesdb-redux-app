public enum Session {
    case none
    case user(User)
    case guest(Guest)
    
    internal init() { self = .none }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
            
        case let action as ReceiveUserSession: self = .user(action.session)
        case let action as ReceiveGuestSession: self = .guest(action.session)
        case is Logout: if case .guest = self { self = Self() }
        case is DeleteUserSessionRequestFailed: self = Self()
        case is DeleteUserSession: self = Self()
        case is RetryLoginFlow: self = Self()
            
        default: break
        }
    }
}

public extension Session {
    struct Id: Hashable {
        public let value: String
        public init(_ value: String) { self.value = value }
    }
}
