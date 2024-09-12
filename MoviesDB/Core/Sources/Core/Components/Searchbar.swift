public struct Searchbar {
    public var query: String = ""
    internal var ids: [Movie.Id] = []
    internal var currentPage: Int = 0
    internal var totalPages: Int = 1
    
    public var canLoad = false
    public var nextPage: Int {
        currentPage + 1
    }
    
    internal var canStartSearch: Bool {
        query.count > 2
    }
    
    internal var hasNextPage: Bool {
        currentPage < totalPages
    }
    
    internal var canRequestNextPage: Bool {
        canStartSearch && hasNextPage
    }
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        case is Logout: self = Self()
        case is ClearSearchQuery: self = Self()
            
        case let action as ReceiveSearchPage:
            let newIds = action.page.movies.map(\.id).filter {
                !ids.contains($0)
            }
            ids.append(contentsOf: newIds)
            currentPage = action.page.page
            totalPages = action.page.totalPages
            canLoad = false
            
        case is RequestNextSearchPage:
            canLoad = canRequestNextPage
            
        case let action as UpdateSearchQuery: 
            if query != action.query {
                self = Self()
                query = action.query
                canLoad = canRequestNextPage
            }
            
        default:
            break
        }
    }
}
