import Combine
import Dispatch

public struct Feedback<State, Action> {
    let execute: (AnyPublisher<State, Never>) -> AnyPublisher<Action, Never>
}

public extension Feedback {
    init<Effect: Publisher>(
        effects: @escaping (State) -> Effect,
        preventDuplicate: Bool = true
    )
    where Effect.Output == Action, Effect.Failure == Never {
        if preventDuplicate {
            let isExecuting = Atomic(false)
            
            self.execute = { state in
                state
                    .filter { _ in !isExecuting.value }
                    .map { currentState in
                        isExecuting.value = true
                        
                        return effects(currentState)
                            .handleEvents(receiveCompletion: { _ in
                                isExecuting.value = false
                            })
                            .eraseToAnyPublisher()
                    }
                    .switchToLatest()
                    .eraseToAnyPublisher()
            }
        } else {
            self.execute = { state in
                state
                    .map { effects($0) }
                    .switchToLatest()
                    .eraseToAnyPublisher()
            }
        }
    }
}
