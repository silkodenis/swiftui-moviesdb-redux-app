public struct MovieList {
    internal var ids: [Movie.Id] = []
    internal var currentPage = 0
    internal var totalPages = 1
    public var canLoad = false
    
    public var nextPage: Int {
        currentPage + 1
    }
    
    internal var hasMorePages: Bool {
        currentPage < totalPages
    }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        case let action as ReceiveMoviePage:
            currentPage = action.page.page
            totalPages = action.page.totalPages
            let newIds = action.page.movies.map(\.id).filter { 
                !ids.contains($0) }
            ids.append(contentsOf: newIds)
            canLoad = false
            
        case is RequestNextMoviePage:
            canLoad = hasMorePages
            
        case is Logout:
            self = Self()
            
        default:
            break
        }
    }
}
