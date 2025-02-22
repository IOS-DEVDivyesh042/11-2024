//
//  ViewController.swift
//  Unitopiaflex
//
//  Created by Manish Bhanushali on 15/10/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vwin1: UIView!
    @IBOutlet weak var TXTINPUT: UITextField!
    @IBOutlet weak var btncalculate: UIButton!
    @IBOutlet weak var lblouput: UILabel!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vwin2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        callinit()
        setupButtonAction()
        setupTextField()
    }

    func callinit() {
        vw1.layer.cornerRadius = 10
        vwin1.layer.cornerRadius = 10
        vw2.layer.cornerRadius = 10
        vwin2.layer.cornerRadius = 10
        TXTINPUT.layer.cornerRadius = 5
        lblouput.layer.cornerRadius = 5
        lblouput.layer.masksToBounds = true
        btncalculate.layer.cornerRadius = 10
    }

    func setupButtonAction() {
        btncalculate.addTarget(self, action: #selector(calculateGravelConversion), for: .touchUpInside)
    }

    func setupTextField() {
        TXTINPUT.delegate = self
        TXTINPUT.keyboardType = .numberPad

        // Create a toolbar with a Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))

        toolbar.setItems([flexSpace, doneButton], animated: false)
        TXTINPUT.inputAccessoryView = toolbar
    }

    @objc func dismissKeyboard() {
        TXTINPUT.resignFirstResponder()  // Dismiss the keyboard
    }

    @objc func calculateGravelConversion() {
        guard let inputText = TXTINPUT.text, let cubicMeters = Double(inputText) else {
            lblouput.text = "Invalid input. Please enter a number."
            return
        }

        // Example conversion: 1 cubic meter of gravel ≈ 1.6 tons
        let conversionFactor = 1.6
        let tons = cubicMeters * conversionFactor

        lblouput.text = "Weight: \(tons) tons"
    }
}
