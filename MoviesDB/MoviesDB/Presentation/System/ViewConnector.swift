import SwiftUI

protocol ViewConnector: View {
    associatedtype Content: View
    func map(graph: Graph) -> Content
    func feedback(action: AppAction) -> Void
}

extension ViewConnector {
    func feedback(action: AppAction) -> Void {}
    
    var body: some View {
        Connected<Content>(map: self.map, feedback: self.feedback(action:))
    }
}

fileprivate struct Connected<V: View>: View {
    @EnvironmentObject private var store: EnvironmentStore
    @State private var isScreenVisible = false
    
    let map: (Graph) -> V
    let feedback: (AppAction) -> Void
    
    var body: some View {
        map(store.graph)
            .onAppear { isScreenVisible = true }
            .onDisappear { isScreenVisible = false }
            .onReceive(store.$action) { action in
                guard let action else {return}
                
                if isScreenVisible {
                    feedback(action)
                }
            }
    }
}
