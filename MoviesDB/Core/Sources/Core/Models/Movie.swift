public struct Movie {
    public let id: Id
    public let title: String
    public let description: String
    public let posterPath: String?
    
    public init(id: Id, title: String, description: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.posterPath = posterPath
    }
}

public extension Movie {
    struct Id: Hashable {
        public let value: Int
        public init(_ value: Int) { self.value = value }
    }
}
