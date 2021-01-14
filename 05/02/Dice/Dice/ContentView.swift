import SwiftUI

struct ContentView {
  @StateObject private var board = Board()
}

extension ContentView: View {
  var body: some View {
    VStack (spacing: 40) {
      board.dieView
      Button("Next",
             action: board.next)
    }
  }
}

