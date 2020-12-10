import UIKit
import Combine

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellable: AnyCancellable?
  
  @Published private var value = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cancellable
      = $value
      .dropFirst()
      .map(\.description)
      .sink {[weak self] string in
        self?.label.text = string
      }
  }
  
  @IBAction private func next(_ sender: UIButton) {
    value = Int.random(in: 1...100)
  }
}

w
