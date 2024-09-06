extension Graph {
    public var loginFlow: LoginFlowNode { LoginFlowNode(graph: self) }
}

public struct LoginFlowNode {
    let graph: Graph
    
    public var flow: LoginFlow     { graph.state.loginFlow }
    public var status: LoginStatus { graph.state.loginStatus }
    public func login()            { graph.dispatch?(Login()) }
    public func enterAsGuest()     { graph.dispatch?(EnterAsGuest()) }
    public func retry()            { graph.dispatch?(RetryLoginFlow()) }
    public func logout()           { graph.dispatch?(Logout()) }
}
