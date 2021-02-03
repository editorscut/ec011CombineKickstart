import Combine
import Foundation
import UIKit.UIImage

class Request: ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  @Published private(set) var results = [AppDetails]()
  @Published var searchTerm = ""
  @Published var images = [String: UIImage]()
  
  init() {
    resultsPipeline()
    imagesPipeline()
  }
}

extension Request {
  private func resultsPipeline() {
    $searchTerm
      .dropFirst()
      .debounce(for: 0.25,
                scheduler: RunLoop.main)
      .removeDuplicates()
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
  
  private func imagesPipeline() {
    $results
      .dropFirst()
      .flatMap{results in
               results.publisher}
      .flatMap {[weak self] result  in
        Future<UIImage?, Never> {promise in
          URLSession.shared
            .dataTask(with: result.artworkURL) { data, _, _ in
            if let image = data.map(UIImage.init(data:)) {
              promise(.success(image))
            }
          }
          .resume()
        }
        .receive(on: RunLoop.main)
        .map {image in
          self?.images[result.name] = image
          return
        }
      }
      .sink{}
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
