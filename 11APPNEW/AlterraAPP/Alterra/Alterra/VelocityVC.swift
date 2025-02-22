//
//  VelocityVC.swift
//  Alterra
//
//  Created by Manish Bhanushali on 09/10/24.
//

import UIKit

class VelocityVC: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var btn1: UIButton! // Button for Unit 1 (m/s)
    @IBOutlet weak var btn2: UIButton! // Button for Unit 2 (km/h)
    @IBOutlet weak var btn3: UIButton! // Button for Unit 3 (mph)
    @IBOutlet weak var btn4: UIButton! // Button for Unit 4 (ft/s)
    @IBOutlet weak var btn5: UIButton! // Button for Unit 5 (knots)
    @IBOutlet weak var lbloutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI elements
        setupViews()
        setupButtons()
        setupKeyboard()
        addDoneButtonToKeyboard()
    }

    // MARK: - Setup Views
    func setupViews() {
        let views = [v1, v2, v3, v4, v5, v6, v7, v8]
        for view in views {
            view?.layer.cornerRadius = 10
            view?.layer.shadowColor = UIColor.black.cgColor
            view?.layer.shadowOpacity = 0.3
            view?.layer.shadowOffset = CGSize(width: 2, height: 2)
            view?.layer.shadowRadius = 5
        }
    }

    func setupKeyboard() {
        txtinput.keyboardType = .numberPad
        addDoneButtonToKeyboard()
        
        // Dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup Buttons
    func setupButtons() {
        let buttons = [btn1, btn2, btn3, btn4, btn5]

        // Array of titles for the buttons
        let buttonTitles = ["m/s", "km/h", "mph", "ft/s", "knots"]

        for (index, button) in buttons.enumerated() {
            button?.layer.cornerRadius = 10
            button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button?.setTitleColor(.white, for: .normal) // Set title color to white
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitle(buttonTitles[index], for: .normal) // Set button title
            button?.tag = index + 1 // Assign a tag for each button (1, 2, 3, 4, 5)
            button?.addTarget(self, action: #selector(convertVelocity(_:)), for: .touchUpInside)
        }
    }

    func addDoneButtonToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]
        txtinput.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        txtinput.resignFirstResponder() // Dismiss keyboard
    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss keyboard when tapping outside
    }
    
    // MARK: - Button Actions
    @IBAction func btncler(_ sender: Any) {
        // Clear the text field and output label
        txtinput.text = ""
        lbloutput.text = ""
    }

    // MARK: - Conversion Logic
    @objc func convertVelocity(_ sender: UIButton) {
        // Perform velocity conversion logic
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input"
            return
        }
        
        let convertedValue = calculateVelocity(input: inputValue, unitTag: sender.tag)
        lbloutput.text = String(format: "%.2f", convertedValue) // Display with 2 decimal places
    }

    // MARK: - Velocity Calculation Logic
    func calculateVelocity(input: Double, unitTag: Int) -> Double {
        // Conversion logic based on the unit selected
        switch unitTag {
        case 1:
            return convertToMetersPerSecond(input: input) // Meters per second (m/s)
        case 2:
            return convertToKilometersPerHour(input: input) // Kilometers per hour (km/h)
        case 3:
            return convertToMilesPerHour(input: input) // Miles per hour (mph)
        case 4:
            return convertToFeetPerSecond(input: input) // Feet per second (ft/s)
        case 5:
            return convertToKnots(input: input) // Knots (kn)
        default:
            return input
        }
    }

    // MARK: - Conversion Functions
    func convertToMetersPerSecond(input: Double) -> Double {
        // Conversion logic to meters per second (no change)
        return input * 1.0
    }

    func convertToKilometersPerHour(input: Double) -> Double {
        // Conversion logic to kilometers per hour
        return input * 3.6 // Convert m/s to km/h
    }

    func convertToMilesPerHour(input: Double) -> Double {
        // Conversion logic to miles per hour
        return input * 2.23694 // Convert m/s to mph
    }

    func convertToFeetPerSecond(input: Double) -> Double {
        // Conversion logic to feet per second
        return input * 3.28084 // Convert m/s to ft/s
    }

    func convertToKnots(input: Double) -> Double {
        // Conversion logic to knots
        return input * 1.94384 // Convert m/s to knots
    }
}
