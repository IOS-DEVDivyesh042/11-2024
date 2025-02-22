import UIKit

class NumberGuessingGameViewController: UIViewController, UITextFieldDelegate {

    // UI Elements
    let textField = UITextField()
    let submitButton = UIButton()
    let coinLabel = UILabel()
    var coins: Int = UserDefaults.standard.integer(forKey: "userCoins") // Get coins from UserDefaults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateCoinLabel() // Update the coin label on view load

        // Add tap gesture to hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        
        // Set up Coin Label
        coinLabel.font = UIFont.systemFont(ofSize: 24)
        coinLabel.textAlignment = .center
        coinLabel.textColor = .white
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coinLabel)

        // Set up TextField
        textField.backgroundColor = UIColor.gold
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter a number"
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)

        // Add "Done" button to the number pad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar

        // Set up Submit Button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitNumber), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            // Coin Label Constraints
            coinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            // TextField Constraints
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: coinLabel.bottomAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 100),
            textField.widthAnchor.constraint(equalToConstant: 300),

            // Submit Button Constraints
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc func submitNumber() {
        // Check if the user has less than 100 coins
        if coins < 100 {
            showAlertToEarnCoins() // Show alert to earn coins
            return
        }
        
        guard let input = textField.text, let tappedBallNumber = Int(input) else {
            showCustomPopup(result: "Error", message: "Invalid input. Please enter a valid number.", tappedBallNumber: 0, highestBallNumber: 0)
            return
        }

        let highestBallNumber = Int.random(in: 1...10) // Simulate a random highest ball number

        if tappedBallNumber == highestBallNumber {
            // Win scenario
            coins += 1000
            UserDefaults.standard.set(coins, forKey: "userCoins")
            updateCoinLabel()
            showCustomPopup(result: "Win", message: "You matched the number!", tappedBallNumber: tappedBallNumber, highestBallNumber: highestBallNumber)
        } else {
            // Lose scenario
            coins -= 100
            UserDefaults.standard.set(coins, forKey: "userCoins")
            updateCoinLabel()
            showCustomPopup(result: "Lose", message: "Not a match. You lost 100 coins.", tappedBallNumber: tappedBallNumber, highestBallNumber: highestBallNumber)
        }
    }
    
    func showAlertToEarnCoins() {
        let alert = UIAlertController(title: "Insufficient Coins", message: "You need at least 100 coins to guess a number. Please earn more coins by going to Trivia.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func updateCoinLabel() {
        coinLabel.text = "Coins: \(coins)"
        
        // Add underline to the coin label
        let text = NSMutableAttributedString(string: coinLabel.text ?? "")
        text.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.length))
        coinLabel.attributedText = text
    }

    func showCustomPopup(result: String, message: String, tappedBallNumber: Int, highestBallNumber: Int) {
        let dimView = UIView(frame: self.view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.tag = 100
        self.view.addSubview(dimView)

        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 10
        popupView.layer.borderColor = UIColor.gray.cgColor
        popupView.layer.borderWidth = 1
        popupView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(popupView)

        let titleLabel = UILabel()
        titleLabel.text = result
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleLabel)

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(messageLabel)

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.systemBlue
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(dismissPopup(_:)), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 280),
            popupView.heightAnchor.constraint(equalToConstant: 220),

            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),

            closeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15),
            closeButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -15),
            closeButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopupByTappingDimView))
        dimView.addGestureRecognizer(tapGesture)
    }

    @objc func dismissPopup(_ sender: UIButton) {
        dismissPopup()
    }

    @objc func dismissPopupByTappingDimView() {
        dismissPopup()
    }

    func dismissPopup() {
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.subviews.last?.removeFromSuperview()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// UIColor extension for custom color
extension UIColor {
    static var gold: UIColor {
        return UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
    }
}

extension NumberGuessingGameViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
