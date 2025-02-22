import UIKit

class POWERVC: UIViewController {
    
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
        outputlabel.numberOfLines = 0

        // Set button titles
        BTN1.setTitle("Watts", for: .normal)
        BTN2.setTitle("Horsepower", for: .normal)

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

    // Button action for power conversion (Watts)
    @IBAction func convertToUnit11(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertPowerToUnit11(inputValue) // Watts conversion logic
        outputlabel.text = "\(convertedValue) Watts"
    }
    
    // Button action for power conversion (Horsepower)
    @IBAction func convertToUnit22(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            outputlabel.text = "Invalid input"
            return
        }
        
        let convertedValue = convertPowerToUnit22(inputValue) // Horsepower conversion logic
        outputlabel.text = "\(convertedValue) Horsepower"
    }
    
    // Conversion logic for Watts
    func convertPowerToUnit11(_ value: Double) -> Double {
        return value * 745.7 // Example conversion: Horsepower to Watts
    }
    
    // Conversion logic for Horsepower
    func convertPowerToUnit22(_ value: Double) -> Double {
        return value / 745.7 // Example conversion: Watts to Horsepower
    }
}
