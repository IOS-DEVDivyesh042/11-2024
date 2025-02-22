//
//  CardGameViewController.swift
//  TreasureTide
//
//  Created by Manish Bhanushali on 23/10/24.
//

import UIKit

class CardGameViewController: UIViewController {
    
    // UI Outlets
    @IBOutlet weak var label1: UILabel!      // Player card label (Human side)
    @IBOutlet weak var lblhuman: UILabel!    // Human side indicator
    @IBOutlet weak var label2: UILabel!      // Computer card label
    @IBOutlet weak var lblcomputer: UILabel! // Computer side indicator
    @IBOutlet weak var lblcoin: UILabel!     // Coin display label
    @IBOutlet weak var btnspin: UIButton!    // Spin button
    
    // Variables
    var playerCardValue: Int = 0
    var computerCardValue: Int = 0
    var totalCoins: Int = 100 {
        didSet {
            updateCoinLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if totalCoins == 0 {
            totalCoins = 1000 // Set initial value
        }
        // Load total coins from UserDefaults
        totalCoins = UserDefaults.standard.integer(forKey: "totalCoins") // Load coins from UserDefaults
        // Set initial UI appearance and values
        setupUI()
        updateCoinLabel()
    }
    
    // Function to initialize UI
    private func setupUI() {
        // Human label setup
        lblhuman.text = "Human"
        lblhuman.textAlignment = .center
        lblhuman.font = UIFont.boldSystemFont(ofSize: 24)
        lblhuman.layer.cornerRadius = 10
        lblhuman.clipsToBounds = true
        
        // Computer label setup
        lblcomputer.text = "Computer"
        lblcomputer.textAlignment = .center
        lblcomputer.font = UIFont.boldSystemFont(ofSize: 24)
        lblcomputer.layer.cornerRadius = 10
        lblcomputer.clipsToBounds = true
        
        // Player Card Label (Human Side)
        label1.textAlignment = .center
        label1.font = UIFont.boldSystemFont(ofSize: 72)
        label1.layer.borderColor = UIColor.black.cgColor
        label1.layer.borderWidth = 2
        label1.layer.cornerRadius = 10
        label1.clipsToBounds = true
        label1.backgroundColor = .brown // Set card background to SystemPurple
        label1.textColor = .white
        
        // Computer Card Label
        label2.textAlignment = .center
        label2.font = UIFont.boldSystemFont(ofSize: 72)
        label2.layer.borderColor = UIColor.black.cgColor
        label2.layer.borderWidth = 2
        label2.layer.cornerRadius = 10
        label2.clipsToBounds = true
        label2.backgroundColor = .brown // Set card background to SystemPurple
        label2.textColor = .white
        
        // Coin Label setup
        lblcoin.textAlignment = .center
        lblcoin.font = UIFont.boldSystemFont(ofSize: 24)
        lblcoin.layer.cornerRadius = 10
        lblcoin.clipsToBounds = true
        lblcoin.backgroundColor = .systemGray5 // Optional background color
        lblcoin.textColor = .black
        
        // Spin Button setup
        btnspin.setTitle("Spin", for: .normal)
        btnspin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btnspin.layer.cornerRadius = 10
        btnspin.clipsToBounds = true
        btnspin.backgroundColor = .brown // Optional button background color
        btnspin.setTitleColor(.white, for: .normal)
    }
    
    // Function to update the coin label
    private func updateCoinLabel() {
        lblcoin.text = "Coins: \(totalCoins)"
    }
    
    // Spin button action (play game logic)
    @IBAction func btnspins(_ sender: Any) {
        if totalCoins < 10 {
            showAlert(title: "Not Enough Coins", message: "You need at least 10 coins to play.")
            return
        }
        
        // Deduct 10 coins for the spin
        totalCoins -= 10
        
        // Generate random values between 1 and 13 for both player and computer
        playerCardValue = Int.random(in: 1...13)
        computerCardValue = Int.random(in: 1...13)
        
        // Update the card labels with the new values
        label1.text = "\(playerCardValue)"
        label2.text = "\(computerCardValue)"
        
        // Check who wins
        if playerCardValue > computerCardValue {
            showAlert(title: "You Win!", message: "You won 100 coins!")
            totalCoins += 1000 // Add 1000 coins on winning
            UserDefaults.standard.set(totalCoins, forKey: "totalCoins") // Save to UserDefaults
        } else if playerCardValue < computerCardValue {
            showAlert(title: "You Lose!", message: "You lost this round.")
        } else {
            showAlert(title: "It's a Tie!", message: "No coins won or lost.")
        }
        
        // Update the coin label after the game round
        updateCoinLabel()
    }
    
    // Function to display alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
