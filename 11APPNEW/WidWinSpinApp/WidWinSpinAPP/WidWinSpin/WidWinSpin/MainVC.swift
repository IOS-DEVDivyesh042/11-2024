//
//  ViewController.swift
//  VegasChase
//
//  Created by Manish Bhanushali on 17/10/24.
//

import UIKit
import StoreKit

class MainVC: UIViewController {

    
    @IBOutlet weak var btnrate: UIButton!
    
    
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var vn1: UIView!
    
    @IBOutlet weak var v2: UIView!
    
    @IBOutlet weak var vn2: UIView!
    
    @IBOutlet weak var v3: UIView!
    
    
    @IBOutlet weak var vn3: UIView!
    
    @IBOutlet weak var v4: UIView!
    
    @IBOutlet weak var vn4: UIView!
    
    @IBOutlet weak var v5: UIView!
    
    @IBOutlet weak var vn5: UIView!
    
    
    @IBOutlet weak var v6: UIView!
    
    @IBOutlet weak var vn6: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCoinsIfNotAdded()
        styleViews()

    }

    @IBAction func ratebtn(_ sender: Any) {
        if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
    }
    
    func addCoinsIfNotAdded() {
          // Check if the coins have already been added
          let hasAddedCoins = UserDefaults.standard.bool(forKey: "hasAddedCoins")
          
          if !hasAddedCoins {
              // Add 1000 coins
              let currentCoins = UserDefaults.standard.integer(forKey: "totalCoins")
              let newTotal = currentCoins + 1000
              UserDefaults.standard.set(newTotal, forKey: "totalCoins")
              // Set the flag to true to indicate coins have been added
              UserDefaults.standard.set(true, forKey: "hasAddedCoins")
              
              print("Added 1000 coins. New total: \(newTotal) coins")
          } else {
              print("Coins have already been added.")
          }
      }
    
    
    func styleViews() {
            let cornerRadius: CGFloat = 10
        let borderColor: UIColor = .brown // Change this to your desired border color
            let borderWidth: CGFloat = 2.0

            let views = [v1, vn1, v2, vn2, v3, vn3, v4, vn4, v5, vn5, v6, vn6]

            for view in views {
                view?.layer.cornerRadius = cornerRadius
                view?.layer.borderColor = borderColor.cgColor
                view?.layer.borderWidth = borderWidth
                view?.clipsToBounds = true // Ensures subviews are clipped to the rounded corners
            }
        }
    
    
    
}

