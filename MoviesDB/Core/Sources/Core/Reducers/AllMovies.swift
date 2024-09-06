public struct AllMovies {
    public var byId: [Movie.Id: Movie] = [:]
    
    mutating func reduce(_ action: AppAction) {
        switch action {
            case let action as ReceiveMoviePage:
                for movie in action.page.movies {
                    byId[movie.id] = movie
                }
            
        case let action as ReceiveSearchPage:
            for movie in action.page.movies {
                byId[movie.id] = movie
            }
            
        case is Logout:
            self = Self()
                
            default: break
        }
    }
}
