import SwiftUI

struct DieView {
  private(set) var dots: Int = 0
}

extension DieView: View {
  var body: some View {
    Image(systemName: "die.face.\(dots)")
      .font(.largeTitle)
  }
}
