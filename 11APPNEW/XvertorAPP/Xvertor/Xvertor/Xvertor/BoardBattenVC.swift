//
//  BoardBattenVC.swift
//  Unitopiaflex
//
//  Created by Manish Bhanushali on 15/10/24.
//

import UIKit

class BoardBattenVC: UIViewController, UITextFieldDelegate {

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
        btncalculate.addTarget(self, action: #selector(calculateBoardBattenConversion), for: .touchUpInside)
    }

    func setupTextField() {
        TXTINPUT.delegate = self
        TXTINPUT.keyboardType = .numberPad

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

    @objc func calculateBoardBattenConversion() {
        guard let inputText = TXTINPUT.text, let inputNumber = Double(inputText) else {
            lblouput.text = "Invalid input. Please enter a number."
            return
        }

        // Example conversion: 1 board & batten installation requires 2.5 linear feet per batten
        let conversionFactor = 2.5
        let result = inputNumber * conversionFactor

        lblouput.text = "Linear Feet: \(result) ft"
    }
}
