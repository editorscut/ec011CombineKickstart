import SwiftUI

struct MainView {
  @StateObject private var request = Request()
  @State private var searchTerm = ""
}

extension MainView: View {
  var body: some View {
    VStack {
      TextField("Enter Search Term",
                text: $searchTerm)
        .multilineTextAlignment(.center)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      List(request.results) {result in
        HStack {
          request.images[result.name].map(Image.init(uiImage:))
          AppDetailsView(appDetails: result)
        }
      }
    }
    .onChange(of: searchTerm){ newSearchTerm in
      request.searchTerm = newSearchTerm
    }
  }
}

