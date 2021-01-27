import SwiftUI

struct ContentView {
  @StateObject private var board = Board()
}

extension ContentView: View {
  var body: some View {
    VStack (spacing: 20) {
      HStack (spacing: 20) {
        board.dieView
        board.greenDieView
      }
      HStack (spacing: 50) {
        Button("Start",
               action: board.start)
          .disabled(board.isRunning)
        Button("Stop",
               action: board.stop)
          .disabled(!board.isRunning)
      }
      Text("History")
      DieHistoryView(dieViews: board.dieViews)
      DieHistoryView(dieViews: board.greenDieViews)
      Text("Merged")
      DieHistoryView(dieViews: board.mergedDieViews)
      Text("Combined")
      CombinedHistoryView(combinedViews: board.combinedViews)
    }
  }
}

