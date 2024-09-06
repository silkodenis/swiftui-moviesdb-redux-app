extension Graph {
    public var movieList: MovieListNode { MovieListNode(graph: self) }
}

public struct MovieListNode {
    let graph: Graph
    var entity: MovieList { graph.state.movieList }
    
    public var movies: [Movie.Id] {
        let list = entity.ids
        let movies = graph.state.allMovies.byId
        let thumbnails = graph.state.allPosters.thumbnails
        
        return list.filter { id in
            return movies.keys.contains(id) &&
               thumbnails.keys.contains(id)
        }
    }
    
    public var loadNextPage: (() -> Void)? {
        guard entity.hasMorePages,
                case .success = graph.loginFlow.status else {
            return nil
            
        }
        
        return { graph.dispatch?(RequestNextMoviePage()) }
    }
}
