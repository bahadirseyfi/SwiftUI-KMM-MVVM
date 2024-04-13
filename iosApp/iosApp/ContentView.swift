import SwiftUI
import Shared

struct ContentView: View {
    @State private var showContent = false
    var body: some View {
        VStack {
            Button("Click me!") {
                withAnimation {
                    showContent = !showContent
                    network()
                }
            }

            if showContent {
                VStack(spacing: 16) {
                    Image(systemName: "swift")
                        .font(.system(size: 200))
                        .foregroundColor(.accentColor)
                    Text("SwiftUI: \(Greeting().greet())")
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
    

    func network() {
        let sdk = ChargePointsRepository()
        sdk.getChargePoints { results, error in
            if let results = results {
                print("Result", results)
            } else {
                print("Localized", error?.localizedDescription)
            }
        }
        /*
        sdk.getChargeStations { results, error in
            if let results = results {
                print("Result", results)
            } else {
                print("Localized", error?.localizedDescription)
            }
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
