import Core
import Combine
import CombineStore
import NavigationCoordinator

typealias Graph = Core.Graph
typealias AppState = Core.AppState
typealias AppAction = Core.AppAction
typealias AppStore = CombineStore.Store<AppState, AppAction>
typealias Feedback = CombineStore.Feedback<AppState, AppAction>
typealias NoEffect = Empty<AppAction, Never>
typealias Coordinator = NavigationCoordinator<Screen>
typealias RootView = NavigationStackRootView<Screen>
