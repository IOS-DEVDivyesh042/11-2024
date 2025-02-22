import UIKit

class ViewController: UIViewController {
    
    // UI Elements
    private var slotImageViews: [UILabel] = []
    private var spinButton: UIButton!
    private var resultLabel: UILabel!
    private var coinLabel: UILabel!
    
    // Symbols for the slot machine
    private let symbols = ["🍒", "🍋", "🍊", "🍉", "🍇", "🔔", "⭐️"]
    
    // Timer for spinning
    private var spinTimer: Timer?
    private var spinDuration: TimeInterval = 5.0
    
    // Coin management
    private var totalCoins: Int {
        get {
            return UserDefaults.standard.integer(forKey: "totalCoins") // Default is 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "totalCoins")
            coinLabel.text = "Coins: \(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Initialize coins if not set
        if totalCoins == 0 {
            totalCoins = 1000 // Set initial value
        }
        
        // Set random symbols in each slot box on the first load
        initializeSlotImages()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Create and configure slot image views
        for _ in 0..<6 {
            let slotLabel = createSlotLabel()
            slotImageViews.append(slotLabel)
            view.addSubview(slotLabel)
        }
        
        // Spin Button
        spinButton = UIButton(type: .system)
        spinButton.setTitle("Spin", for: .normal)
        spinButton.layer.backgroundColor = UIColor.white.cgColor
        spinButton.layer.cornerRadius = 10
        spinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        spinButton.addTarget(self, action: #selector(spinSlots), for: .touchUpInside)
        
        // Result Label
        resultLabel = UILabel()
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        // Coin Label
        coinLabel = UILabel()
        coinLabel.textAlignment = .center
        coinLabel.layer.backgroundColor = UIColor.white.cgColor
        coinLabel.layer.cornerRadius = 10
        coinLabel.font = UIFont.boldSystemFont(ofSize: 24)
        coinLabel.text = "Coins: \(totalCoins)"
        
        // Adding subviews
        view.addSubview(spinButton)
        view.addSubview(resultLabel)
        view.addSubview(coinLabel)
        
        // Set up AutoLayout
        setupConstraints()
    }
    
    private func createSlotLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.backgroundColor = UIColor.brown.cgColor
        return label
    }
    
    private func setupConstraints() {
        // Enable AutoLayout
        slotImageViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        spinButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for slot image views (2 rows, 3 columns)
        let rows = 2
        let columns = 3
        
        for row in 0..<rows {
            for column in 0..<columns {
                let index = row * columns + column
                NSLayoutConstraint.activate([
                    slotImageViews[index].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100 + CGFloat(row) * 120),
                    slotImageViews[index].centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat(column) * 120 - 120),
                    slotImageViews[index].widthAnchor.constraint(equalToConstant: 100),
                    slotImageViews[index].heightAnchor.constraint(equalToConstant: 100),
                ])
            }
        }
        
        // Spin Button Constraints
        NSLayoutConstraint.activate([
            spinButton.topAnchor.constraint(equalTo: slotImageViews[0].bottomAnchor, constant: 200),
            spinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: spinButton.bottomAnchor, constant: 20),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coinLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            coinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func initializeSlotImages() {
        // Set random symbol for each slot label on first load
        for slotImageView in slotImageViews {
            slotImageView.text = symbols.randomElement()
        }
    }
    
    @objc private func spinSlots() {
        // Prevent spinning if coins are less than 100
        if totalCoins < 100 {
            showAlert(title: "Not Enough Coins", message: "You need at least 100 coins to spin.")
            return
        }
        
        resultLabel.text = ""
        
        // Start spinning animation
        spinAnimation()
        
        // Start a timer to stop the spinning after a duration
        spinTimer = Timer.scheduledTimer(timeInterval: spinDuration, target: self, selector: #selector(stopSpinning), userInfo: nil, repeats: false)
    }
    
    private func spinAnimation() {
        // Animate the slot labels to simulate spinning
        let originalPositions = slotImageViews.map { $0.center.y }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.repeat, .autoreverse]) {
            // Move the labels down and then back up
            for slotImageView in self.slotImageViews {
                slotImageView.center.y += 20
            }
        } completion: { _ in
            // Reset positions after animation ends
            for (index, slotImageView) in self.slotImageViews.enumerated() {
                slotImageView.center.y = originalPositions[index]
            }
        }
    }
    
    @objc private func stopSpinning() {
        spinTimer?.invalidate()
        
        // Stop the spinning animation
        for slotImageView in slotImageViews {
            slotImageView.layer.removeAllAnimations()
        }
        
        // Get random results for all slots
        let results = slotImageViews.map { _ in symbols.randomElement()! }
        
        // Update slot images
        for (index, slotImageView) in slotImageViews.enumerated() {
            slotImageView.text = results[index]
        }
        
        // Check win condition
        if results.allSatisfy({ $0 == results[0] }) {
            updateCoins(by: 1000) // Add 1000 coins on win
            showAlert(title: "Congratulations!", message: "You won 1000 coins!")
        } else {
            updateCoins(by: -100) // Subtract 100 coins on loss
            showAlert(title: "Better Luck Next Time", message: "You lost 100 coins. Try again!")
        }
    }
    
    private func updateCoins(by amount: Int) {
        totalCoins += amount
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
