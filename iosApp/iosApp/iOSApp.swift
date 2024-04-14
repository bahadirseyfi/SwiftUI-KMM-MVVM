import SwiftUI
import Shared

@main
struct iOSApp: App {
	var body: some Scene {
        let sdk = ChargePointsRepository()
		WindowGroup {
            MainView(viewModel: MainViewModel(kmmRepository: sdk))
		}
	}
}
