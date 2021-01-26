import SwiftUI

struct DieViewPreviousFive {
  let dieViews: [DieView]
}

extension DieViewPreviousFive: View {
  var body: some View {
    LazyHGrid(rows: [GridItem(.flexible())]) {
      ForEach(dieViews) {view in
        view
      }
    }
  }
}
