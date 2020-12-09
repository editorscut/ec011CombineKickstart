import UIKit
import Combine

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellable: AnyCancellable?
  
  @Published private var value = 0 {
    didSet {
      print(value.description)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cancellable
      = $value
      .sink {[weak self] int in
        self?.label.text = int.description
      }
  }
  
  @IBAction private func next(_ sender: UIButton) {
    value = Int.random(in: 1...100)
  }
}

