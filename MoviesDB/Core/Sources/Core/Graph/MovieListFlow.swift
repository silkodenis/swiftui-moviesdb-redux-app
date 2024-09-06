extension Graph {
    public var movieListFlow: MovieListFlowNode { MovieListFlowNode(graph: self) }
}

public struct MovieListFlowNode {
    let graph: Graph
    var movieList: MovieListNode { graph.movieList }
    var searchbar: SearchbarNode { graph.searchbar }
    
    public var ids: [Movie.Id] {
        if searchbar.query.isEmpty {
            return movieList.movies
        } else {
            return searchbar.movies
        }
    }
    
    public var title: String {
        if searchbar.query.isEmpty {
            return "Trending Movies"
        } else {
            return searchbar.query
        }
    }
    
    public var loadNextPage: (() -> Void)? {
        if searchbar.query.isEmpty {
            return movieList.loadNextPage
        } else {
            return searchbar.loadNextPage
        }
    }
}
