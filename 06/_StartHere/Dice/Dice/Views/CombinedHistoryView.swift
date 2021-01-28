import SwiftUI

struct CombinedHistoryView {
  let combinedViews: [(DieView, DieView)]
}

extension CombinedHistoryView: View {
  var body: some View {
    ScrollView {
      VStack {
        ForEach(combinedViews.indices, id: \.self) {index in
          HStack {
            combinedViews[index].0
            combinedViews[index].1
          }
        }
      }
    }
  }
}

