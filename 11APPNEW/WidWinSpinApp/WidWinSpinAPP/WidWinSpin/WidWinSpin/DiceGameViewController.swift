import UIKit

class DiceGameViewController: UIViewController {
    
    // Coin balance stored in UserDefaults
    var coinBalance: Int {
        get {
            UserDefaults.standard.integer(forKey: "totalCoins")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "totalCoins")
        }
    }
    
    var targetNumber: Int = Int.random(in: 1...9) // Random target number between 1 and 9
    
    let resultLabel = UILabel()
    let coinLabel = UILabel()
    let inputTextField = UITextField() // TextField for user to enter their guess
    let submitButton = UIButton(type: .system)
    let targetNumberLabel = UILabel() // Label to display the target number
    
    // Create an array to hold buttons for numbers 1-9
    var numberButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        resetGame()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Setup result label
        resultLabel.textAlignment = .center
        resultLabel.textColor = .white
        resultLabel.font = UIFont.systemFont(ofSize: 24)
        resultLabel.layer.backgroundColor = UIColor.brown.cgColor
        resultLabel.layer.cornerRadius = 10
      //  resultLabel.font = UIFont(name: "Chalkduster", size: 22)
        resultLabel.text = "Guess a number (1 to 9)" // Set initial text for result label
        view.addSubview(resultLabel)
        
        // Setup coin label
        coinLabel.textAlignment = .center
        coinLabel.font = UIFont.systemFont(ofSize: 24)
        coinLabel.textColor = .white
        coinLabel.layer.cornerRadius = 10
        coinLabel.layer.backgroundColor = UIColor.brown.cgColor
       // coinLabel.font = UIFont(name: "Chalkduster", size: 22)
        coinLabel.text = "Coins: \(coinBalance)"  // Set initial text for coin label
        view.addSubview(coinLabel)
        
        // Setup target number label
        targetNumberLabel.textAlignment = .center
        targetNumberLabel.font = UIFont.systemFont(ofSize: 24)
        targetNumberLabel.textColor = .black
        targetNumberLabel.font = UIFont(name: "Chalkduster", size: 22)
        targetNumberLabel.text = "" // Initially empty
        view.addSubview(targetNumberLabel)

        // Setup text field for user input
        inputTextField.borderStyle = .roundedRect
        inputTextField.placeholder = "Enter a number (1-9)"
        inputTextField.textAlignment = .center
        inputTextField.keyboardType = .numberPad
        view.addSubview(inputTextField)
        
        // Setup submit button
        submitButton.setTitle("Submit Guess", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        submitButton.backgroundColor = .brown
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitGuess), for: .touchUpInside)
        view.addSubview(submitButton)

        let buttonColors: [UIColor] = [.red, .green, .blue, .orange, .purple, .cyan, .magenta, .brown, .yellow] // Array of different colors
        
        // Create buttons for numbers 1 to 9
        for i in 1...9 {
            let button = UIButton(type: .system)
            button.setTitle("\(i)", for: .normal)
            button.tag = i
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16) // Set title color to bold black
            button.backgroundColor = .systemYellow // Set button color to gold
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside) // Add action for button tap
            view.addSubview(button)
            numberButtons.append(button)
        }
        
        // Layout for result label
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        // Layout for coin label
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coinLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            coinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinLabel.heightAnchor.constraint(equalToConstant: 40),
            coinLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        // Layout for target number label
        targetNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            targetNumberLabel.topAnchor.constraint(equalTo: coinLabel.bottomAnchor, constant: 20),
            targetNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            targetNumberLabel.heightAnchor.constraint(equalToConstant: 40),
            targetNumberLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        // Layout for input text field
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: targetNumberLabel.bottomAnchor, constant: 20),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        // Layout for submit button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        // Button Size and Padding
        let buttonSize: CGFloat = 50 // Changed button size to 20x20
        let padding: CGFloat = 10
        
        // Row 1 - 4 buttons centered
        let row1CenterX = view.center.x - (3 * (buttonSize + padding) / 2)
        for i in 0..<4 {
            let button = numberButtons[i]
            button.tintColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: buttonSize),
                    button.heightAnchor.constraint(equalToConstant: buttonSize),
                    button.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding + CGFloat(i) * (buttonSize + padding)),
                    button.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -padding) // Keep trailing constraint
                ])
        }
        
        // Row 2 - 3 buttons centered
        let row2CenterX = view.center.x - (2 * (buttonSize + padding) / 2)
        for i in 4..<7 {
            let button = numberButtons[i]
            button.tintColor = .brown
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20 + buttonSize + padding), // Position below row 1
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: row2CenterX + CGFloat(i - 4) * (buttonSize + padding))
            ])
        }
        
        // Row 3 - 2 buttons centered
        let row3CenterX = view.center.x - (buttonSize + padding) / 2
        for i in 7..<9 {
            let button = numberButtons[i]
            button.tintColor = .systemIndigo
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20 + 2 * (buttonSize + padding)), // Position below row 2
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: row3CenterX + CGFloat(i - 7) * (buttonSize + padding))
            ])
        }
    }
    
    func resetGame() {
        targetNumber = Int.random(in: 1...9) // Reset target number
        resultLabel.text = "Guess a number (1 to 9)" // Reset result label
        coinLabel.text = "Coins: \(coinBalance)" // Update coin balance
        targetNumberLabel.text = "" // Clear the target number label initially
    }
    
    @objc func submitGuess() {
        guard let guess = Int(inputTextField.text ?? ""), guess >= 1 && guess <= 9 else {
            showPopUp(message: "Please enter a valid number between 1 and 9.")
            return
        }
        
        let guessedNumber = guess
        
        // Check if the guessed number is correct
        if guessedNumber == targetNumber {
            showWinPopUp()
            coinBalance += 10 // Reward coins for correct guess
        } else {
            showLossPopUp(correctNumber: targetNumber)
            coinBalance -= 5 // Deduct coins for wrong guess
        }
        coinLabel.text = "Coins: \(coinBalance)" // Update coin balance
        resetGame() // Reset game after each guess
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Trigger animation when a number button is tapped
        animateButton(button: sender)
        inputTextField.text = "\(sender.tag)" // Set text field to the button's number
        submitGuess() // Call submit guess method after tapping the button
    }

    func animateButton(button: UIButton) {
        // Perform the animation on button tap
        UIView.animate(withDuration: 0.5, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // Scale up
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                button.transform = CGAffineTransform.identity // Scale back to original size
            }
        }
    }

    func showPopUp(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showWinPopUp() {
        let alert = UIAlertController(title: "Congratulations!", message: "You guessed correctly! You earned 10 coins.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showLossPopUp(correctNumber: Int) {
        let alert = UIAlertController(title: "Oops!", message: "Wrong guess! The correct number was \(correctNumber). You lost 5 coins.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func animateAllButtons() {
        for button in numberButtons {
            UIView.animate(withDuration: 0.5, animations: {
                button.alpha = 0.5
            }) { _ in
                UIView.animate(withDuration: 0.5) {
                    button.alpha = 1.0
                }
            }
        }
    }
}
