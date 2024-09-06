import SwiftUI
import Core

enum Screen {
    case login
    case moviesList
    case movieDetail(id: Movie.Id)
}

extension Screen: Navigable {
    @ViewBuilder
    var view: some View {
        switch self {
        case .login: LoginFlowViewConnector()
        case .moviesList: MovieListViewConnector()
        case .movieDetail(let id): MovieDetailFlowViewConnector(id: id)
        }
    }
}
