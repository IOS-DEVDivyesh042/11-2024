//
//  Velocity.swift
//  Xvertor
//
//  Created by Manish Bhanushali on 13/10/24.
//

import UIKit

class Velocity: UIViewController, UITextFieldDelegate {
    
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
        lblinputunitname.text = "Enter velocity in meters per second (m/s)" // Set input label text
    }
    
    @IBAction func btnoutputunit(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input. Please enter a valid number."
            return
        }
        
        // Velocity Conversion Logic
        let metersPerSecond = inputValue
        let kilometersPerHour = metersPerSecond * 3.6
        let milesPerHour = metersPerSecond * 2.23694

        lbloutput.text = """
        Meters per second: \(String(format: "%.2f", metersPerSecond)) m/s
        Kilometers per hour: \(String(format: "%.2f", kilometersPerHour)) km/h
        Miles per hour: \(String(format: "%.2f", milesPerHour)) mph
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
