public struct Password {
    public let string: String
    
    private init(_ string: String) {
        self.string = string
    }
    
    enum ValidationError: Error { case tooShort }
    
    static func parse(_ rawString: String) -> Result<Password, ValidationError> {
        guard rawString.count > 6 else {
            return .failure(.tooShort)
        }
        
        return .success(Password(rawString))
    }
}
