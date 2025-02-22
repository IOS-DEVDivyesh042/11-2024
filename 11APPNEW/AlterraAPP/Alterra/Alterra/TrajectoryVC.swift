//
//  TrajectoryVC.swift
//  Alterra
//
//  Created by Manish Bhanushali on 09/10/24.
//

import UIKit

class TrajectoryVC: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var btn1: UIButton! // Button for Unit 1 (m)
    @IBOutlet weak var btn2: UIButton! // Button for Unit 2 (km)
    @IBOutlet weak var btn3: UIButton! // Button for Unit 3 (ft)
    @IBOutlet weak var btn4: UIButton! // Button for Unit 4 (mi)
    @IBOutlet weak var btn5: UIButton! // Button for Unit 5 (yd)
    @IBOutlet weak var lbloutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI elements
        setupViews()
        setupButtons()
        setupKeyboard()
        addDoneButtonToKeyboard()
    }
    
    func setupKeyboard() {
        txtinput.keyboardType = .numberPad
        addDoneButtonToKeyboard()
        
        // Dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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

    // MARK: - Setup Buttons
    func setupButtons() {
        let buttons = [btn1, btn2, btn3, btn4, btn5]

        // Array of titles for the buttons
        let buttonTitles = ["Meters (m)", "Kilometers (km)", "Feet (ft)", "Miles (mi)", "Yards (yd)"]

        for (index, button) in buttons.enumerated() {
            button?.layer.cornerRadius = 10
            button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button?.setTitleColor(.white, for: .normal) // Set title color to white
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitle(buttonTitles[index], for: .normal) // Set button title
            button?.tag = index + 1 // Assign a tag for each button (1, 2, 3, 4, 5)
            button?.addTarget(self, action: #selector(convertTrajectory(_:)), for: .touchUpInside)
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
    @objc func convertTrajectory(_ sender: UIButton) {
        // Perform trajectory conversion logic
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input"
            return
        }
        
        let convertedValue = calculateTrajectory(input: inputValue, unitTag: sender.tag)
        lbloutput.text = String(format: "%.2f", convertedValue) // Display with 2 decimal places
    }

    // MARK: - Trajectory Calculation Logic
    func calculateTrajectory(input: Double, unitTag: Int) -> Double {
        // Conversion logic based on the unit selected
        switch unitTag {
        case 1:
            return convertToMeters(input: input) // Meters (m)
        case 2:
            return convertToKilometers(input: input) // Kilometers (km)
        case 3:
            return convertToFeet(input: input) // Feet (ft)
        case 4:
            return convertToMiles(input: input) // Miles (mi)
        case 5:
            return convertToYards(input: input) // Yards (yd)
        default:
            return input
        }
    }

    // MARK: - Conversion Functions
    func convertToMeters(input: Double) -> Double {
        // Conversion logic to meters (no change)
        return input * 1.0
    }

    func convertToKilometers(input: Double) -> Double {
        // Conversion logic to kilometers
        return input / 1000.0 // Convert meters to kilometers
    }

    func convertToFeet(input: Double) -> Double {
        // Conversion logic to feet
        return input * 3.28084 // Convert meters to feet
    }

    func convertToMiles(input: Double) -> Double {
        // Conversion logic to miles
        return input * 0.000621371 // Convert meters to miles
    }

    func convertToYards(input: Double) -> Double {
        // Conversion logic to yards
        return input * 1.09361 // Convert meters to yards
    }
}
