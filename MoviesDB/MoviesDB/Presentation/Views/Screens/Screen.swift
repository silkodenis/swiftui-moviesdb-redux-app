import SwiftUI
import Core
import NavigationCoordinator

enum Screen {
    case login
    case moviesList
    case movieDetail(id: Movie.Id)
}

extension Screen: NavigableScreen {
    @ViewBuilder
    var view: some View {
        switch self {
        case .login: LoginFlowViewConnector()
        case .moviesList: MovieListViewConnector()
        case .movieDetail(let id): MovieDetailFlowViewConnector(id: id)
        }
    }
}
