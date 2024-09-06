import Foundation

public struct Graph {
    public typealias Dispatch = (AppAction) -> Void
    let state: AppState
    let dispatch: Dispatch?
    
    public init(
        state: AppState,
        dispatch: Dispatch? = nil) {
            self.state = state
            self.dispatch = dispatch
        }
}
