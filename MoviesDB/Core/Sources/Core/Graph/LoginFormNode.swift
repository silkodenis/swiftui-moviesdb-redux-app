extension Graph {
    public var loginForm: LoginFormNode { LoginFormNode(graph: self) }
}

public struct LoginFormNode {
    var graph: Graph
    
    public var username: String {
        get { graph.state.loginForm.rawUsername }
        nonmutating set { graph.dispatch?(UpdateUsername(newValue))}
    }
    
    public var password: String {
        get { graph.state.loginForm.rawPassword }
        nonmutating set { graph.dispatch?(UpdatePassword(newValue))}
    }
        
    public var isValidCredentials: Bool { graph.state.loginForm.credentials != nil }
}
