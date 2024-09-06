import SwiftUI

struct StoreProvider<Content: View>: View {
    let store: AppStore
    let content: () -> Content
    
    var body: some View {
        content()
            .environmentObject(EnvironmentStore(store: store))
    }
}
    
