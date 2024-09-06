extension Graph {
    public var searchbar: SearchbarNode { SearchbarNode(graph: self) }
}

public struct SearchbarNode {
    let graph: Graph
    var entity: Searchbar { graph.state.searchbar }
    
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
        guard entity.canRequestNextPage,
                case .success = graph.loginFlow.status else {
            return nil
        }
        
        return { graph.dispatch?(RequestNextSearchPage()) }
    }
    
    public var query: String {
        get { graph.state.searchbar.query }
        nonmutating set { graph.dispatch?(UpdateSearchQuery(newValue))}
    }
    
    public func clear() { graph.dispatch?(ClearSearchQuery()) }
}

