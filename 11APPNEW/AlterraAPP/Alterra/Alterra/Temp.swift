//
//  Temp.swift
//  Xvertor
//
//  Created by Manish Bhanushali on 13/10/24.
//

import UIKit

class Temp: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var lblinputunitname: UILabel!
    
    @IBOutlet weak var txtinput: UITextField!
    
    @IBOutlet weak var btncalculate: UIButton!
    
    
    @IBOutlet weak var lbloutput: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtinput.delegate = self
                
                // Add Done button to keyboard
                addDoneButtonOnKeyboard()
        
        btncalculate.layer.cornerRadius = 10
               
               // Additional setup (optional)
               lbloutput.numberOfLines = 0 // Allows multi-line output
               lblinputunitname.text = "Enter temperature in Celsius"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnoutputunit(_ sender: Any) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
                    lbloutput.text = "Invalid input. Please enter a number."
                    return
                }
                
                let celsius = inputValue
                let fahrenheit = (celsius * 9/5) + 32
                let kelvin = celsius + 273.15
                
                lbloutput.text = """
                Celsius: \(String(format: "%.2f", celsius)) °C
                Fahrenheit: \(String(format: "%.2f", fahrenheit)) °F
                Kelvin: \(String(format: "%.2f", kelvin)) K
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
