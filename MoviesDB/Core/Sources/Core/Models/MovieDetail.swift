
public struct MovieDetail {
    public let movie: Movie.Id
    public let title: String
    public let runtime: Int?
    public let genres: [String]
    public let overview: String?
    public let languages: [String]
    public let countries: [String]
    public let posterPath: String
    public let voteAverage: Double?
    public let releaseDate: String?

    public init(movie: Movie.Id, title: String, runtime: Int?,
                genres: [String], overview: String?, languages: [String], countries: [String],
                posterPath: String, voteAverage: Double?, releaseDate: String?) {
        self.movie = movie
        self.title = title
        self.runtime = runtime
        self.genres = genres
        self.overview = overview
        self.languages = languages
        self.countries = countries
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }
}
