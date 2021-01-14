import SwiftUI

struct MainView {
  private let board = Board()
}

extension MainView: View {
  var body: some View {
    VStack(spacing: 40) {
      DieView(dots: 3)
      Button("Next",
             action: board.next)
    }
  }
}
