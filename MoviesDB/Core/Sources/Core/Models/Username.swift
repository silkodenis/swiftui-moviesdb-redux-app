public struct Username {
    public let string: String
    
    private init(_ string: String) {
        self.string = string
    }
    
    enum ValidationError: Error { case tooShort }
    
    static func parse(_ rawString: String) -> Result<Username, ValidationError> {
        guard rawString.count > 3 else {
            return .failure(.tooShort)
        }
        
        return .success(Username(rawString))
    }
}
