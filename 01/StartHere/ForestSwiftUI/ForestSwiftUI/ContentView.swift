import SwiftUI

struct ContentView {
  private func next() {
  }
}

extension ContentView: View {
    var body: some View {
      VStack(spacing: 100) {
        Text("...")
        Button("Next",
               action: next)
      }
    }
}


