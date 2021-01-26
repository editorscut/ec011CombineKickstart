import SwiftUI

struct ContentView {
  @StateObject private var board = Board()
}

extension ContentView: View {
  var body: some View {
    VStack (spacing: 40) {
      board.dieView
      HStack (spacing: 50) {
        Button("Start",
               action: board.start)
          .disabled(board.isRunning)
        Button("Stop",
               action: board.stop)
          .disabled(!board.isRunning)
      }
      Text("Previous Five")
      DieViewPreviousFive(dieViews: board.dieViews)
    }
  }
}

