//
//  Volume.swift
//  Xvertor
//
//  Created by Manish Bhanushali on 13/10/24.
//

import UIKit

class Volume: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblinputunitname: UILabel!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var btncalculate: UIButton!
    @IBOutlet weak var lbloutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtinput.delegate = self
                
                // Add Done button to keyboard
                addDoneButtonOnKeyboard()
        // Set corner radius for the calculate button
        btncalculate.layer.cornerRadius = 10
        
        // Additional setup
        lbloutput.numberOfLines = 0 // Allow multi-line output
        lblinputunitname.text = "Enter volume in Liters" // Set input label text
    }
    
    @IBAction func btnoutputunit(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input. Please enter a valid number."
            return
        }
        
        // Volume Conversion Logic
        let liters = inputValue
        let milliliters = liters * 1000
        let cubicMeters = liters / 1000

        lbloutput.text = """
        Liters: \(String(format: "%.2f", liters)) L
        Milliliters: \(String(format: "%.2f", milliliters)) mL
        Cubic Meters: \(String(format: "%.6f", cubicMeters)) m³
        """
    }
    
    
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [flexSpace, doneButton]
        txtinput.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        txtinput.resignFirstResponder() // Dismiss the keyboard
    }
}
