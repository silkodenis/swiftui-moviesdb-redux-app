public struct AppState {
    public var session = Session()
    public var loginForm = LoginForm()
    public var loginFlow = LoginFlow()
    public var loginStatus = LoginStatus()
    public var searchbar = Searchbar()
    public var movieList = MovieList()
    public var signUpFlow = SignUpFlow()
    public var allMovieDetails = AllMovieDetails()
    public var allMovies = AllMovies()
    public var allPosters = AllPosters()
    
    public init() {}
    
    public mutating func reduce(_ action: AppAction) {
        session.reduce(action)
        loginForm.reduce(action)
        loginFlow.reduce(action)
        loginStatus.reduce(action)
        searchbar.reduce(action)
        movieList.reduce(action)
        signUpFlow.reduce(action)
        allMovieDetails.reduce(action)
        allMovies.reduce(action)
        allPosters.reduce(action)
    }
}
