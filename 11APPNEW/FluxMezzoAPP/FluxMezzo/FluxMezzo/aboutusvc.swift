//
//  aboutusvc.swift
//  FluxMezzo
//
//  Created by Manish Bhanushali on 03/10/24.
//

import UIKit

class aboutusvc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
setGradientBackground()
        // Do any additional setup after loading the view.
    }
    

    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Colors for each corner
        gradientLayer.colors = [
            UIColor.yellow.cgColor,  // Top-left
            UIColor.orange.cgColor,   // Top-right
            UIColor.red.cgColor,      // Bottom-left
            UIColor.blue.cgColor       // Bottom-right
        ]
        
        // Set color positions for each corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Top-left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)    // Bottom-right
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
