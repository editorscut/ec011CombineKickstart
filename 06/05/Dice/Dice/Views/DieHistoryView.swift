import SwiftUI

struct DieHistoryView {
  let dieViews: [DieView]
}

extension DieHistoryView: View {
  var body: some View {
    ScrollView (.horizontal) {
    LazyHGrid(rows: [GridItem(.fixed(20))]) {
        ForEach(dieViews) {view in
          view
        }
    }
    .fixedSize()
    }
  }
}

