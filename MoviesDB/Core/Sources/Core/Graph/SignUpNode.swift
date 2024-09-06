import Foundation

extension Graph {
    public var signUp: SignUpNode { SignUpNode(graph: self) }
}

public struct SignUpNode {
    let graph: Graph
    
    public var url: URL? { graph.state.signUpFlow.url }
}
