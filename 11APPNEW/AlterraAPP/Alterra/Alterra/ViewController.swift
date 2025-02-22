//
//  ViewController.swift
//  Alterra
//
//  Created by Manish Bhanushali on 09/10/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btntra: UIButton!
    
    @IBOutlet weak var btnveloci: UIButton!
    
    
    @IBOutlet weak var btnmagnit: UIButton!
    
    
    @IBOutlet weak var btnmoment: UIButton!
    
    
    @IBOutlet weak var btnfeedback: UIButton!
    
    @IBOutlet weak var btnaboutus: UIButton!
    
    @IBOutlet weak var btnrate: UIButton!
    
    @IBOutlet weak var btncolour: UIButton!
    
    var isBackgroundColorBlue: Bool = false //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callinit()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btncolour(_ sender: Any) {
        
        if !isBackgroundColorBlue {
                   // Set background color to blue and title color to white for all buttons
                   setButtonAppearance(button: btntra, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnveloci, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnmagnit, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnmoment, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnfeedback, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnaboutus, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btnrate, backgroundColor: .blue, titleColor: .white)
                   setButtonAppearance(button: btncolour, backgroundColor: .blue, titleColor: .white)
               } else {
                   // Reset background color to white and title color to black for all buttons
                   setButtonAppearance(button: btntra, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnveloci, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnmagnit, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnmoment, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnfeedback, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnaboutus, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btnrate, backgroundColor: .white, titleColor: .black)
                   setButtonAppearance(button: btncolour, backgroundColor: .white, titleColor: .black)
               }
        isBackgroundColorBlue.toggle()
    }
    
    
    func callinit(){
        btntra.layer.cornerRadius = 10
        btnveloci.layer.cornerRadius = 10
        btnmagnit.layer.cornerRadius = 10
        btnmoment.layer.cornerRadius = 10
        btnfeedback.layer.cornerRadius = 10
        btnaboutus.layer.cornerRadius = 10
        btnrate.layer.cornerRadius = 10
        btncolour.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func btnrate(_ sender: Any) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
        
    }
    func setButtonAppearance(button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
          button.backgroundColor = backgroundColor
          button.setTitleColor(titleColor, for: .normal)
      }
    

}

