import Foundation

// TODO: finish it
public struct SignUpFlow {
    public var url: URL?
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        case let action as ReceiveSignUpURL: 
            url = action.url
            
        default:
            break
        }
    }
}
