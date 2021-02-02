import Combine
import Foundation

class Request: ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  @Published private(set) var results = [AppDetails]()
  
  func search(for searchTerm: String) {
    Just(searchTerm)
      .map(applyFormatting)
      .compactMap(iTunesURL)
      .flatMap {url in
        URLSession.shared
          .dataTaskPublisher(for: url)
      }
      .map(\.data)
      .decode(type: SearchResults.self,
              decoder: JSONDecoder())
      .map(\.results)
      .catch {error in
        Just([AppDetails]())
      }
      .receive(on: RunLoop.main)
      .assign(to: &$results)
  }
}

extension Request {
  private func applyFormatting(to rawTerm: String) -> String {
    rawTerm.replacingOccurrences(of: " ",
                                 with: "+")
  }
  
  private func iTunesURL(for formattedTerm: String) -> URL? {
    var components = iTunesURLBase
    components
      .queryItems?
      .append(URLQueryItem(name: "term",
                           value: formattedTerm))
    return components.url
  }
}
