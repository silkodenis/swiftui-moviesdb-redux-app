import SwiftUI
import Combine
import Core

class EnvironmentStore: ObservableObject {
    @Published private(set) var graph: Graph
    @Published private(set) var action: AppAction?
    
    private var cancellables = Set<AnyCancellable>()
    private let store: AppStore

    init(store: AppStore) {
        self.store = store
        self.graph = Graph(state: store.state, 
                           dispatch: store.dispatch(action:))
        bindStore()
    }
    
    private func bindStore() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else {return}
                
                self.graph = Graph(state: state, 
                                   dispatch: self.store.dispatch(action:))
            }
            .store(in: &cancellables)
        
        store.feedbackOutputPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.action = action
            }
            .store(in: &cancellables)
    }
}
