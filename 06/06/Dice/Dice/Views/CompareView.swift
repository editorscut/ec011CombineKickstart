import SwiftUI

struct CompareView {
  let values: (Int, Int)
}

extension CompareView: View {
  var body: some View {
    Image(systemName: imageName)
  }
}

extension CompareView {
  var imageName: String {
    switch (values.0 - values.1) {
    case 0:
      return "equal"
    case ..<0:
      return "lessthan"
    default:
      return "greaterthan"
    }
  }
}
