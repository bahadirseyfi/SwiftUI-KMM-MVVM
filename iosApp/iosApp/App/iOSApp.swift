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
                        Label(E.Strings.Title.main,
                              systemImage: E.Strings.Images.house)
                    }
                FavoriteView()
                    .tabItem {
                        Label(E.Strings.Title.favorite,
                              systemImage: E.Strings.Images.heartFill)
                    }
            }
        }
    }
}
