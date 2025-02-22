//
//  MainVC.swift
//  Unitopiaflex
//
//  Created by Manish Bhanushali on 15/10/24.
//

import UIKit
import StoreKit

class MainVC: UIViewController {
    
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var v2: UIView!
    
    @IBOutlet weak var v3: UIView!
    
    @IBOutlet weak var v4: UIView!
    
    
    @IBOutlet weak var v5: UIView!
    
    @IBOutlet weak var v6: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callinits()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnrate(_ sender: Any) {
        if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
    }
    
    
    func callinits(){
        v1.layer.cornerRadius = 5
        v2.layer.cornerRadius = 5
        v3.layer.cornerRadius = 5
        v4.layer.cornerRadius = 5
        v5.layer.cornerRadius = 5
        v6.layer.cornerRadius = 5
        
        
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
