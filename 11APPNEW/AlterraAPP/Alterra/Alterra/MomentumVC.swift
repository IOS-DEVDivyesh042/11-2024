import UIKit

class MomentumVC: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var btn1: UIButton! // Button for Unit 1
    @IBOutlet weak var btn2: UIButton! // Button for Unit 2
    @IBOutlet weak var btn3: UIButton! // Button for Unit 3
    @IBOutlet weak var btn4: UIButton! // Button for Unit 4
    @IBOutlet weak var btn5: UIButton! // Button for Unit 5
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
    
    // MARK: - Setup Buttons
    func setupButtons() {
        let buttons = [btn1, btn2, btn3, btn4, btn5]

        // Array of titles for the buttons
        let buttonTitles = ["Kg·m/s", "N·s", "g·cm/s", "lb·s", "dyn·s"]

        for (index, button) in buttons.enumerated() {
            button?.layer.cornerRadius = 10
            button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button?.setTitleColor(.white, for: .normal) // Set title color to white
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitle(buttonTitles[index], for: .normal) // Set button title
            button?.tag = index + 1 // Assign a tag for each button (1, 2, 3, 4, 5)
            button?.addTarget(self, action: #selector(convertMomentum(_:)), for: .touchUpInside)
        }
    }

    // MARK: - Button Actions
    @IBAction func btncler(_ sender: Any) {
        // Clear the text field and output label
        txtinput.text = ""
        lbloutput.text = ""
    }

    // MARK: - Conversion Logic
    @objc func convertMomentum(_ sender: UIButton) {
        // Perform momentum conversion logic
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input"
            return
        }
        
        let convertedValue = calculateMomentum(input: inputValue, unitTag: sender.tag)
        lbloutput.text = String(format: "%.2f", convertedValue) // Display with 2 decimal places
    }

    // MARK: - Momentum Calculation Logic
    func calculateMomentum(input: Double, unitTag: Int) -> Double {
        // Conversion logic based on the unit selected
        switch unitTag {
        case 1:
            return convertToKgMS(input: input) // Kilogram meter per second (kg·m/s)
        case 2:
            return convertToNewtonSecond(input: input) // Newton second (N·s)
        case 3:
            return convertToGramCMS(input: input) // Gram centimeter per second (g·cm/s)
        case 4:
            return convertToPoundFSecond(input: input) // Pound-force second (lb·s)
        case 5:
            return convertToDyneSecond(input: input) // Dyne second (dyn·s)
        default:
            return input
        }
    }

    // MARK: - Conversion Functions
    func convertToKgMS(input: Double) -> Double {
        // Conversion logic to kilogram meter per second
        return input * 1.0 // Example conversion (no change)
    }

    func convertToNewtonSecond(input: Double) -> Double {
        // Conversion logic to Newton second
        return input * 1.0 // Example conversion (no change)
    }

    func convertToGramCMS(input: Double) -> Double {
        // Conversion logic to Gram centimeter per second
        return input * 1000.0 // Convert kg·m/s to g·cm/s
    }

    func convertToPoundFSecond(input: Double) -> Double {
        // Conversion logic to Pound-force second
        return input * 0.224809 // Convert kg·m/s to lb·s
    }

    func convertToDyneSecond(input: Double) -> Double {
        // Conversion logic to Dyne second
        return input * 100000.0 // Convert kg·m/s to dyn·s
    }
}
