import UIKit

class TicTacToeViewController: UIViewController {

    // UI Elements
    var gridButtons: [UIButton] = []
    let playerIcon = UIImageView()
    let computerIcon = UIImageView()
    let humanLabel = UILabel()
    let computerLabel = UILabel()
    let coinLabel = UILabel()
    var coins: Int = UserDefaults.standard.integer(forKey: "userCoins")
    var currentPlayer: Player = .human
    var gameBoard: [Player?] = Array(repeating: nil, count: 9)

    enum Player {
        case human
        case computer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default coins if not already set
        if coins == 0 {
            coins = 1000
            UserDefaults.standard.set(coins, forKey: "userCoins")
        }
        
        setupUI()
        updateCoinLabel() // Show initial coins
    }

    func setupUI() {
        view.backgroundColor = .systemGray6

        // Coin Label
        coinLabel.font = UIFont.systemFont(ofSize: 24)
        coinLabel.textAlignment = .center
        coinLabel.textColor = .white // White color for the label
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coinLabel)

        // Create Tic Tac Toe grid buttons
        let gridSize: CGFloat = 100
        let gridSpacing: CGFloat = 10

        for i in 0..<9 {
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.tag = i
            button.addTarget(self, action: #selector(gridButtonTapped(_:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            gridButtons.append(button)
        }

        // Player Icons and Labels
        playerIcon.image = UIImage(named: "humanIcon") // Replace with your image
        playerIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerIcon)

        computerIcon.image = UIImage(named: "computerIcon") // Replace with your image
        computerIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(computerIcon)

        // Human Label
        let humanText = "Human"
        humanLabel.attributedText = NSAttributedString(string: humanText, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        humanLabel.textColor = .white
        humanLabel.textAlignment = .center
        humanLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(humanLabel)

        // Computer Label
        let computerText = "Computer"
        computerLabel.attributedText = NSAttributedString(string: computerText, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        computerLabel.textColor = .white
        computerLabel.textAlignment = .center
        computerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(computerLabel)

        // Layout Constraints
        setupConstraints(gridSize: gridSize, gridSpacing: gridSpacing)
    }

    func setupConstraints(gridSize: CGFloat, gridSpacing: CGFloat) {
        NSLayoutConstraint.activate([
            // Coin Label Constraints
            coinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            // Player Icons and Labels Constraints
            playerIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            playerIcon.topAnchor.constraint(equalTo: coinLabel.bottomAnchor, constant: 20),
            playerIcon.widthAnchor.constraint(equalToConstant: 40),
            playerIcon.heightAnchor.constraint(equalToConstant: 40),

            humanLabel.centerXAnchor.constraint(equalTo: playerIcon.centerXAnchor),
            humanLabel.topAnchor.constraint(equalTo: playerIcon.bottomAnchor, constant: 5),

            computerIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),
            computerIcon.topAnchor.constraint(equalTo: coinLabel.bottomAnchor, constant: 20),
            computerIcon.widthAnchor.constraint(equalToConstant: 40),
            computerIcon.heightAnchor.constraint(equalToConstant: 40),

            computerLabel.centerXAnchor.constraint(equalTo: computerIcon.centerXAnchor),
            computerLabel.topAnchor.constraint(equalTo: computerIcon.bottomAnchor, constant: 5)
        ])

        // Grid Buttons Constraints
        for i in 0..<3 {
            for j in 0..<3 {
                let button = gridButtons[i * 3 + j]
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: gridSize),
                    button.heightAnchor.constraint(equalToConstant: gridSize),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(j) * (gridSize + gridSpacing) + (view.frame.width - (gridSize * 3 + gridSpacing * 2)) / 2),
                    button.topAnchor.constraint(equalTo: playerIcon.bottomAnchor, constant: CGFloat(i) * (gridSize + gridSpacing) + 40)
                ])
            }
        }
    }

    @objc func gridButtonTapped(_ sender: UIButton) {
        if currentPlayer == .human {
            // Mark human's move
            sender.setTitle("O", for: .normal)
            sender.isEnabled = false
            gameBoard[sender.tag] = .human

            if checkWin(for: .human) {
                // Player wins
                coins += 1000
                UserDefaults.standard.set(coins, forKey: "userCoins")
                updateCoinLabel()
                showAlert(title: "You Win!", message: "Congratulations, you won!")
                return
            }

            // Check for a draw (all spots filled)
            if !gameBoard.contains(nil) {
                showAlert(title: "It's a Draw!", message: "No more moves left!")
                return
            }

            currentPlayer = .computer
            computerMove()
        }
    }

    func computerMove() {
        // Simple AI: choose the first available spot
        if let index = gameBoard.firstIndex(of: nil) {
            gameBoard[index] = .computer
            let button = gridButtons[index]
            button.setTitle("X", for: .normal)
            button.isEnabled = false

            if checkWin(for: .computer) {
                // Player loses
                coins -= 100
                UserDefaults.standard.set(coins, forKey: "userCoins")
                updateCoinLabel()
                showAlert(title: "You Lose!", message: "The computer won!")
                return
            }

            // Check for a draw
            if !gameBoard.contains(nil) {
                showAlert(title: "It's a Draw!", message: "No more moves left!")
                return
            }

            currentPlayer = .human
        }
    }

    func checkWin(for player: Player) -> Bool {
        // Winning logic here
        let winningCombinations: [[Int]] = [
            [0, 1, 2], // Top row
            [3, 4, 5], // Middle row
            [6, 7, 8], // Bottom row
            [0, 3, 6], // Left column
            [1, 4, 7], // Middle column
            [2, 5, 8], // Right column
            [0, 4, 8], // Diagonal
            [2, 4, 6]  // Other diagonal
        ]

        // Check if the player has a winning combination
        for combination in winningCombinations {
            if combination.allSatisfy({ gameBoard[$0] == player }) {
                return true
            }
        }

        return false
    }

    func updateCoinLabel() {
        coinLabel.text = "Coins: \(coins)"
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.restartGame() // Restart the game when alert is dismissed
        }))
        present(alert, animated: true, completion: nil)
    }

    func restartGame() {
        // Reset the game state
        gameBoard = Array(repeating: nil, count: 9)
        currentPlayer = .human
        for button in gridButtons {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
    }
}
