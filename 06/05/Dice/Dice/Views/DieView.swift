import SwiftUI

struct DieView: Identifiable {
  private(set) var dots: Int = 0
  private var color: Color = .black
  let id = UUID()
}

extension DieView: View {
  var body: some View {
    dieFace
      .font(.largeTitle)
      .foregroundColor(color)
  }
}

extension DieView {
  init(_ dots: Int) {
    self.init(dots: dots)
  }
  
  static func green(_ dots: Int = 0) -> DieView {
    DieView(dots: dots,
            color: .green)
  }
}

extension DieView {
  private var dieFace: Image {
    guard (1...60).contains(dots) else {
      return Image(systemName: "square")
    }
    return Image(systemName: "die.face.\(dots)")
  }
}
