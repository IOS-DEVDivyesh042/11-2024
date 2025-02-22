//
//  Temp.swift
//  Xvertor
//
//  Created by Manish Bhanushali on 13/10/24.
//

import UIKit

class Magnet: UIViewController, UITextFieldDelegate {
    
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
        lblinputunitname.text = "Enter magnetic field strength in Tesla" // Set input label text
    }
    
    @IBAction func btnoutputunit(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input. Please enter a valid number."
            return
        }
        
        // Magnetic Field Conversion Logic
        let tesla = inputValue
        let gauss = tesla * 10_000
        let microtesla = tesla * 1_000_000

        lbloutput.text = """
        Tesla: \(String(format: "%.2f", tesla)) T
        Gauss: \(String(format: "%.2f", gauss)) G
        Microtesla: \(String(format: "%.2f", microtesla)) µT
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
