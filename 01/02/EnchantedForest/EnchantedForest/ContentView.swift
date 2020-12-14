import SwiftUI

struct ContentView {
  @State private var value = 0
  
  private func next() {
    value = Int.random(in: 1...100)
  }
}

extension ContentView: View {
  var body: some View {
    VStack(spacing: 100) {
      Text(value.description)
      Button("Next",
             action: next)
    }
  }
}
