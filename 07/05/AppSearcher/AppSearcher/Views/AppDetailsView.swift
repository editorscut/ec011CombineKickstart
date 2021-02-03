import SwiftUI

struct AppDetailsView {
  let appDetails: AppDetails
}

extension AppDetailsView: View {
  var body: some View {
    VStack (alignment: .leading) {
      Text(appDetails.name)
        .font(.headline)
      HStack {
        Text(Int(appDetails.rating.rounded()).description)
          .foregroundColor(.secondary)
          .font(.largeTitle)
        Spacer()
        Text(appDetails.sellerName).font(.footnote)
      }
    }
  }
}
