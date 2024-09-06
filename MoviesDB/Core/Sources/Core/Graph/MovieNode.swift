import Foundation

extension Graph {
    public func movie(id: Movie.Id) -> MovieNode {
        return MovieNode(graph: self, id: id)
    }
}

public struct MovieNode {
    let graph: Graph
    let id: Movie.Id
    
    var movie: Movie? { graph.state.allMovies.byId[id] }
    var poster: Poster? {graph.state.allPosters.thumbnails[id]}
    
    public var title: String { movie?.title ?? "" }
    public var description: String { movie?.description ?? "" }
    public var posterData: Data? { poster?.data }
    public func select() { graph.dispatch?(SelectMovieRow(id)) }
}
