import Core
import Combine
import CombineReduxStore
import NavigationCoordinator

typealias Graph = Core.Graph
typealias AppState = Core.AppState
typealias AppAction = Core.AppAction
typealias NoEffect = Empty<AppAction, Never>
typealias AppStore = CombineReduxStore.Store<AppState, AppAction>
typealias Feedback = CombineReduxStore.Feedback<AppState, AppAction>
typealias Coordinator = NavigationCoordinator<Screen>
typealias RootView = NavigationStackRootView<Screen>
