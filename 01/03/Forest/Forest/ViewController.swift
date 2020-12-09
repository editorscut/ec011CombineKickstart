import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  
  private var value = 0 {
    didSet {
      label.text = value.description
    }
  }
  
  @IBAction private func next(_ sender: UIButton) {
    value = Int.random(in: 1...100)
  }
}

