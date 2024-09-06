public struct AllMovieDetails {
    public var byId: [Movie.Id: MovieDetail] = [:]
    public var selectedMovie: Movie.Id?
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        case let action as ReceiveMovieDetail:
            byId[action.details.movie] = action.details
            
        case let action as SelectMovieRow:
            if !byId.keys.contains(action.id) {
                selectedMovie = action.id
            }
            
        case is Logout:
            self = Self()
            
        default: break
        }
    }
}
