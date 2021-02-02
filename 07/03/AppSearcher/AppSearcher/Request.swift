import Combine
import Foundation

class Request: ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  
  func search(for searchTerm: String) {
    Just(searchTerm)
      .map(applyFormatting)
      .compactMap(iTunesURL)
      .flatMap {url in
        URLSession.shared
          .dataTaskPublisher(for: url)
      }
      .map(\.data)
      .compactMap {rawData in
        String(data: rawData,
               encoding: .utf8)
      }
      .sink(receiveCompletion: {completion in
        print("Completed:", completion)
      }, receiveValue: { string in
        print("Data:", string)
      })
      .store(in: &cancellables)
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
