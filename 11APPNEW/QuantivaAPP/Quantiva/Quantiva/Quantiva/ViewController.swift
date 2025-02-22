//
//  ViewController.swift
//  Quantiva
//
//  Created by Manish Bhanushali on 07/10/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var btn1: UIView!
    
    @IBOutlet weak var btn11: UIButton!
    
    @IBOutlet weak var btn22: UIButton!
    
    
    
    @IBOutlet weak var btn33: UIButton!
    
    
    
    
    @IBOutlet weak var btn44: UIButton!
    
    
    
    @IBOutlet weak var view2: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callkit()
        // Do any additional setup after loading the view.
    }
    
    
    func callkit(){
        btn1.layer.cornerRadius = 10
        btn11.layer.cornerRadius = 10
        btn22.layer.cornerRadius = 10
        btn33.layer.cornerRadius = 10
        btn44.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        
    }

    @IBAction func rate(_ sender: Any) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    
    func createBubbleAnimation(at point: CGPoint) {
            let bubble = UIView(frame: CGRect(x: point.x, y: point.y, width: 20, height: 20))
            bubble.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
            bubble.layer.cornerRadius = 10
            bubble.layer.masksToBounds = true
            self.view.addSubview(bubble)

            // Create the animation
            UIView.animate(withDuration: 1.0, animations: {
                bubble.transform = CGAffineTransform(scaleX: 2.0, y: 2.0) // Bubble expands
                bubble.alpha = 0 // Fade out
                bubble.center.y -= 100 // Move up
            }) { _ in
                bubble.removeFromSuperview() // Remove the bubble after animation
            }
        }

    @IBAction func btn11(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).center
        createBubbleAnimation(at: buttonPosition!)
    }
    
    @IBAction func btn22(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).center
        createBubbleAnimation(at: buttonPosition!)
    }
    
    @IBAction func btn33(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).center
        createBubbleAnimation(at: buttonPosition!)
    }
    
    @IBAction func btn44(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).center
        createBubbleAnimation(at: buttonPosition!)
    }
    
    
    
}

