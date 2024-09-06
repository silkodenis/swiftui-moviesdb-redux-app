import Foundation

extension Graph {
    public var poster: PosterNode { PosterNode(graph: self) }
}

public struct PosterNode {
    let graph: Graph
    
    public func thumbnail(id: Movie.Id) -> Poster? {
        graph.state.allPosters.thumbnails[id] }
    
    public func detail(id: Movie.Id) -> Poster? {
        graph.state.allPosters.details[id] }
}
