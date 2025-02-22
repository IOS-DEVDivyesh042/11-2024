import UIKit

class ENERGYVC: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var outputlabel: UILabel!
    @IBOutlet weak var BTN1: UIButton!
    @IBOutlet weak var BTN2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply corner radius to views, buttons, and label
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        BTN1.layer.cornerRadius = 10
        BTN2.layer.cornerRadius = 10
        outputlabel.layer.cornerRadius = 10
        outputlabel.layer.masksToBounds = true
        outputlabel.numberOfLines = 0
        
        // Set button titles
        BTN1.setTitle("Calories", for: .normal)
        BTN2.setTitle("Joules", for: .normal)

        // Setup input text field with number pad and "Done" button
        txtinput.keyboardType = .numberPad
        addDoneButtonToKeyboard()
        
        // Dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // Function to add "Done" button to the keyboard
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

    // Button action for conversion to Calories
    @IBAction func convertToUnit1(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertEnergyToUnit1(inputValue)
        outputlabel.text = "\(convertedValue) Calories"
    }
    
    // Button action for conversion to Joules
    @IBAction func convertToUnit2(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertEnergyToUnit2(inputValue)
        outputlabel.text = "\(convertedValue) Joules"
    }
    
    // Conversion logic for Calories
    func convertEnergyToUnit1(_ value: Double) -> Double {
        return value * 0.239006 // Example conversion to Calories
    }
    
    // Conversion logic for Joules
    func convertEnergyToUnit2(_ value: Double) -> Double {
        return value * 1000 // Example conversion to Joules
    }
}
