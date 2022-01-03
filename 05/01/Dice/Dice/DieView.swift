import SwiftUI

struct DieView {
  private(set) var dots: Int = 0
}

extension DieView: View {
  var body: some View {
    dieFace.font(.largeTitle)
  }
}

extension DieView {
  private var dieFace: Image {
    guard (1...6).contains(dots) else {
      return Image(systemName: "square")
    }
    return Image(systemName: "die.face.\(dots)")
  }
}
