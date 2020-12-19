import SwiftUI

struct MainView {
  @StateObject private var link = Link()
}

extension MainView: View {
  var body: some View {
    VStack(spacing: 80) {
      Text(link.contents)
      Button("Next",
             action: {link.next()})
    }
  }
}
