import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  
  @Published private var value = 0 {
    didSet {
      print(value.description)
    }
  }
  
  @IBAction private func next(_ sender: UIButton) {
    value = Int.random(in: 1...100)
  }
}

