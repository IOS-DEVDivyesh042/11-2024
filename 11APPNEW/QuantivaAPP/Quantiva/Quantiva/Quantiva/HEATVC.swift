import UIKit

class HEATVC: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var outputlabel: UILabel!
    @IBOutlet weak var BTN1: UIButton!
    @IBOutlet weak var BTN2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply corner radius to views and buttons
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        BTN1.layer.cornerRadius = 10
        BTN2.layer.cornerRadius = 10
        outputlabel.layer.cornerRadius = 10
        outputlabel.layer.masksToBounds = true

        // Set button titles
        BTN1.setTitle("Celsius", for: .normal)
        BTN2.setTitle("Fahrenheit", for: .normal)

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

    // Button action for heat conversion (Celsius)
    @IBAction func convertToUnit1(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertHeatToUnit1(inputValue) // Conversion to Celsius
        outputlabel.text = "\(convertedValue) °C"
    }
    
    // Button action for heat conversion (Fahrenheit)
    @IBAction func convertToUnit2(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertHeatToUnit2(inputValue) // Conversion to Fahrenheit
        outputlabel.text = "\(convertedValue) °F"
    }
    
    // Conversion logic for Celsius
    func convertHeatToUnit1(_ value: Double) -> Double {
        return (value - 32) * 5/9 // Example conversion: Fahrenheit to Celsius
    }
    
    // Conversion logic for Fahrenheit
    func convertHeatToUnit2(_ value: Double) -> Double {
        return (value * 9/5) + 32 // Example conversion: Celsius to Fahrenheit
    }
}
