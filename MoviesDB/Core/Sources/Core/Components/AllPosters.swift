public struct AllPosters {
    public var thumbnails: [Movie.Id: Poster] = [:]
    public var details: [Movie.Id: Poster] = [:]
    
    mutating func reduce(_ action: AppAction) {
        switch action {
        case let action as ReceiveThumbnailPosters:
            thumbnails.merge(action.posters) { _, new in new }
 
        case let action as ReceiveDetailPoster:
            details[action.poster.movie] = action.poster
            
        case is Logout:
            self = Self()
            
        default: break
        }
    }
}
