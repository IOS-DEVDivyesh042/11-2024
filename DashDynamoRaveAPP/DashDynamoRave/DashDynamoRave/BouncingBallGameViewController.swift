import UIKit

class BouncingBallGameViewController: UIViewController {

    var balls: [UIView] = []
    var bounceHeights: [CGFloat] = [] // Store bounce height for each ball
    var gameTimer: Timer?
    var coinBalanceLabel: UILabel!

    // User's coin balance stored in UserDefaults
    var userCoins: Int {
        get { return UserDefaults.standard.integer(forKey: "userCoins") }
        set {
            UserDefaults.standard.set(newValue, forKey: "userCoins")
            updateCoinBalanceLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCoinBalanceLabel()
        setupBalls()
        
        // Set initial user coins
        userCoins = max(userCoins, 1000)
        
        // Check if the user has enough coins to play
        checkCoinBalance()
    }

    func setupCoinBalanceLabel() {
        coinBalanceLabel = UILabel()
        coinBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        coinBalanceLabel.textAlignment = .center
        coinBalanceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        coinBalanceLabel.textColor = .white
        updateCoinBalanceLabel()

        view.addSubview(coinBalanceLabel)

        NSLayoutConstraint.activate([
            coinBalanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coinBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func updateCoinBalanceLabel() {
        coinBalanceLabel.text = "Coins: \(userCoins)"
    }

    func setupBalls() {
        let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange, .systemPurple]

        for i in 0..<5 {
            let bounceHeight = CGFloat.random(in: 100...400) // Assign a random bounce height
            bounceHeights.append(bounceHeight)
            
            let ball = UIView()
            ball.backgroundColor = colors[i % colors.count]
            ball.layer.cornerRadius = 25
            ball.translatesAutoresizingMaskIntoConstraints = false
            ball.layer.shadowColor = UIColor.black.cgColor
            ball.layer.shadowOpacity = 0.3
            ball.layer.shadowOffset = CGSize(width: 3, height: 3)
            ball.layer.shadowRadius = 5
            
            // Label for ball number
            let label = UILabel()
            label.text = "Ball \(i + 1)" // Show only the ball number
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            ball.addSubview(label)
            
            view.addSubview(ball)
            balls.append(ball)

            NSLayoutConstraint.activate([
                ball.widthAnchor.constraint(equalToConstant: 50),
                ball.heightAnchor.constraint(equalToConstant: 50),
                ball.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat.random(in: -100...100)),
                ball.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                
                label.centerXAnchor.constraint(equalTo: ball.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: ball.centerYAnchor)
            ])

            // Add tap gesture to each ball
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ballTapped(_:)))
            ball.addGestureRecognizer(tapGesture)
            
            // Start bounce animation
            startBounceAnimation(for: ball, bounceHeight: bounceHeight)
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkHighestBall), userInfo: nil, repeats: true)
    }

    func startBounceAnimation(for ball: UIView, bounceHeight: CGFloat) {
        let duration = Double.random(in: 0.6...1.5)

        UIView.animate(withDuration: duration, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            ball.transform = CGAffineTransform(translationX: 0, y: -bounceHeight)
        }, completion: nil)
    }

    @objc func checkHighestBall() {
        balls.forEach { $0.layer.borderWidth = 0 } // Clear previous highlights
    }

    @objc func ballTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedBall = sender.view else { return }

        // Determine the highest bounce ball based on stored bounce heights
        if let highestBounceHeight = bounceHeights.max(),
           let tappedBallIndex = balls.firstIndex(of: tappedBall) {
            
            let tappedBallBounceHeight = bounceHeights[tappedBallIndex]
            let highestBallIndex = bounceHeights.firstIndex(of: highestBounceHeight) ?? 0
            
            print("Highest bounce height: \(highestBounceHeight), Tapped ball bounce height: \(tappedBallBounceHeight)")
            
            // Compare tapped ball's bounce height with highest bounce height
            if tappedBallBounceHeight == highestBounceHeight {
                userCoins += 5000
                showCustomPopup(result: "Win!", message: "You selected the highest bounce ball!", tappedBallNumber: tappedBallIndex + 1, highestBallNumber: highestBallIndex + 1)
            } else {
                userCoins -= 100
                showCustomPopup(result: "Lose", message: "Try again to pick the highest bounce ball.", tappedBallNumber: tappedBallIndex + 1, highestBallNumber: highestBallIndex + 1)
            }
            
            checkCoinBalance()
        }
        
        // Highlight tapped ball with purple border
        balls.forEach { $0.layer.borderWidth = 0 }
        tappedBall.layer.borderWidth = 4
        tappedBall.layer.borderColor = UIColor.purple.cgColor
    }

    func checkCoinBalance() {
        if userCoins < 100 {
            showLowCoinPopup()
        }
    }

    func showCustomPopup(result: String, message: String, tappedBallNumber: Int, highestBallNumber: Int) {
        // Stop bouncing animation when popup appears
     //   stopBounceAnimation()

        // Create popup container view
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 10
        popupView.layer.borderColor = UIColor.gray.cgColor
        popupView.layer.borderWidth = 1
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        // Title label for result (Win/Lose)
        let titleLabel = UILabel()
        titleLabel.text = result
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleLabel)
        
        // Message label with formatted message details
        let messageLabel = UILabel()
        messageLabel.text = """
        \(message)
        
        • Selected Ball: \(tappedBallNumber)
        • Highest Bounce Ball: \(highestBallNumber)
        """
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(messageLabel)
        
        // Close button to dismiss the popup
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.systemBlue // Change to desired background color
        closeButton.layer.cornerRadius = 10 // Set corner radius
        closeButton.addTarget(self, action: #selector(dismissPopup(_:)), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(closeButton)
        
        // Set layout constraints for the popup and its subviews
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 280),
            popupView.heightAnchor.constraint(equalToConstant: 220), // Increased height for spacing
            
            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15), // Position below message label
            closeButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -15),
            closeButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func stopBounceAnimation() {
        // Stop all bounce animations for the balls
        for ball in balls {
            ball.layer.removeAllAnimations()
            ball.transform = .identity // Reset the position to avoid jump
        }
    }

    func showLowCoinPopup() {
        let alert = UIAlertController(title: "Low Coins", message: "You don't have enough coins to continue playing. Please earn more coins.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func dismissPopup(_ sender: UIButton) {
        // Simply remove the popup view without restarting animations
        if let popupView = sender.superview {
            popupView.removeFromSuperview()
        }
    }

    func startBounceAnimations() {
        for (index, ball) in balls.enumerated() {
            let bounceHeight = bounceHeights[index]
            startBounceAnimation(for: ball, bounceHeight: bounceHeight)
        }
    }
}
