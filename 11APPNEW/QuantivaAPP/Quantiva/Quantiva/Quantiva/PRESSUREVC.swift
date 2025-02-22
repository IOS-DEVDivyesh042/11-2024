import UIKit

class PRESSUREVC: UIViewController {
    
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
        BTN1.setTitle("Pascals", for: .normal)
        BTN2.setTitle("PSI", for: .normal)

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

    // Button action for pressure conversion (Pascals)
    @IBAction func convertToUnit1(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertPressureToUnit1(inputValue) // Conversion to Pascals
        outputlabel.text = "\(convertedValue) Pascals"
    }
    
    // Button action for pressure conversion (PSI)
    @IBAction func convertToUnit2(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertPressureToUnit2(inputValue) // Conversion to PSI
        outputlabel.text = "\(convertedValue) PSI"
    }
    
    // Conversion logic for Pascals (Pa)
    func convertPressureToUnit1(_ value: Double) -> Double {
        return value * 6894.76 // Example conversion: PSI to Pascals
    }
    
    // Conversion logic for PSI
    func convertPressureToUnit2(_ value: Double) -> Double {
        return value / 6894.76 // Example conversion: Pascals to PSI
    }
}
