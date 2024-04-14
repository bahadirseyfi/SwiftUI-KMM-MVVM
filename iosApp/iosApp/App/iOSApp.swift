import SwiftUI
import Shared
import SwiftData

@main
struct iOSApp: App {
    var body: some Scene {
        let kmmRepository = ChargePointsRepository()
        
        WindowGroup {
            TabView {
                MainView(kmmRepository: kmmRepository)
                    .tabItem {
                        Label("Main", systemImage: "gear")
                    }
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "gear")
                    }
            }
        }
    }
}
