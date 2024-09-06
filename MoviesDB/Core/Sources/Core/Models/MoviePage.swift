public struct MoviePage {
    public let movies: [Movie]
    public let page: Int
    public let totalPages: Int
    
    public init(movies: [Movie], page: Int, totalPages: Int) {
        self.movies = movies
        self.page = page
        self.totalPages = totalPages
    }
}
