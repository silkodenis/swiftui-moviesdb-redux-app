import Foundation

public struct Poster {
    public let data: Data
    public let movie: Movie.Id
    
    public init(data: Data, movie: Movie.Id) {
        self.data = data
        self.movie = movie
    }
}
