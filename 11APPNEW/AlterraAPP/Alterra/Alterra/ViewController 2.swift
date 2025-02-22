//
//  ViewController.swift
//  Xvertor
//
//  Created by Manish Bhanushali on 13/10/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnvol: UIButton!
    
    @IBOutlet weak var btnveloc: UIButton!
    
    @IBOutlet weak var btnmagnet: UIButton!
    
    @IBOutlet weak var btntemp: UIButton!
    
    
    @IBOutlet weak var btnfeed: UIButton!
    
    @IBOutlet weak var btnabout: UIButton!
    
    @IBOutlet weak var btnrate: UIButton!
    
    @IBOutlet weak var bwblue: UIView!
    
    
    @IBOutlet weak var viewgray: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callinit()
       
    }
    
   
    
    func callinit(){
        btnvol.layer.cornerRadius = 10
        btnveloc.layer.cornerRadius = 10
        btnmagnet.layer.cornerRadius = 10
        btntemp.layer.cornerRadius = 10
        btnfeed.layer.cornerRadius = 10
        btnabout.layer.cornerRadius = 10
        btnrate.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func btnratee(_ sender: Any) {
        
        if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
    }
    

}

