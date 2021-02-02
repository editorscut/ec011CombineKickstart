import SwiftUI

struct ContentView {
  @StateObject private var board = Board()
}

extension ContentView: View {
  var body: some View {
    VStack (spacing: 20) {
      HStack (spacing: 20) {
        board.dieView
        board.compareView
        board.greenDieView
      }
      HStack (spacing: 60) {
        Button("Start",
               action: board.start)
          .disabled(board.isRunning)
        Button("Stop",
               action: board.stop)
          .disabled(!board.isRunning)
      }
    }
  }
}

