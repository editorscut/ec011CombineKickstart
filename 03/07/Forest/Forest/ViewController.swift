import UIKit
import Combine

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellables: Set<AnyCancellable> = Set()
  private let link = Link()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    labelSubscription().store(in: &cancellables)
  }
  
  @IBAction private func next(_ sender: UIButton) {
    link.next()
  }
}

extension ViewController {
  private func labelSubscription() -> AnyCancellable {
    link.$contents
      .assign(to: \.text, on: label)
  }
}
