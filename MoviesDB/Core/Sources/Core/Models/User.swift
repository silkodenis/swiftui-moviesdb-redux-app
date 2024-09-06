public extension Session {
    struct User {
        public let token: Token
        public let id: Session.Id
        
        public init(token: Token, id: Session.Id) {
            self.token = token
            self.id = id
        }
    }
}
