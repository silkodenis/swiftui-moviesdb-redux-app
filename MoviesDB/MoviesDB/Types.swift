import Core
import Combine
import ReduxStore

typealias Graph = Core.Graph
typealias AppState = Core.AppState
typealias AppAction = Core.AppAction
typealias NoEffect = Empty<AppAction, Never>
typealias Coordinator = NavigationCoordinator<Screen>
typealias AppStore = ReduxStore.Store<AppState, AppAction>
typealias Feedback = ReduxStore.Feedback<AppState, AppAction>
