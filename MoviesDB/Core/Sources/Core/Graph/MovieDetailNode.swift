import Foundation

extension Graph {
    public func movieDetail(id: Movie.Id) -> MovieDetailNode {
        return MovieDetailNode(graph: self, id: id)
    }
}

public struct MovieDetailNode {
    let graph: Graph
    let id: Movie.Id
    
    var detail: MovieDetail? { graph.state.allMovieDetails.byId[id] }
    var poster: Poster? { graph.poster.detail(id: id) }
    
    public var genres: [String] { detail?.genres ?? [] }
    public var rating: Double? { detail?.voteAverage }
    public var overview: String? { detail?.overview }
    public var runtime: Int? { detail?.runtime }
    public var releaseAt: String? { detail?.releaseDate }
    public var countries: [String]? { detail?.countries }
    public var posterData: Data? { poster?.data }
    
    public var isLoading: Bool {
        guard let _ = detail,
              let _ = posterData else {
            return true
        }
        
        return false
    }
}
