public extension Session {
    struct Guest {
        public let id: Session.Id
        
        public init(id: Session.Id) {
            self.id = id
        }
    }
}
