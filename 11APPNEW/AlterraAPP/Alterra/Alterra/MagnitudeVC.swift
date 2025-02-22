import UIKit

class MagnitudeVC: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var txtinput: UITextField!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var lbloutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupButtons()
        setupKeyboard()
        addDoneButtonToKeyboard()// Set up keyboard and tap recognizer
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
        let buttons = [btn1, btn2, btn3, btn4, btn5, btn6]
        let buttonTitles = ["Newtons (N)", "Pounds (lb)", "Meters (m)", "Feet (ft)", "Kilograms (kg)", "Grams (g)"]

        for (index, button) in buttons.enumerated() {
            button?.layer.cornerRadius = 10
            button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button?.setTitleColor(.white, for: .normal)
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitle(buttonTitles[index], for: .normal)
            button?.tag = index + 1
            button?.addTarget(self, action: #selector(convertMagnitude(_:)), for: .touchUpInside)
        }
    }

    // MARK: - Setup Keyboard and Tap Recognizer
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

    // MARK: - Button Actions
    @IBAction func btncler(_ sender: Any) {
        txtinput.text = ""
        lbloutput.text = ""
    }

    // MARK: - Conversion Logic
    @objc func convertMagnitude(_ sender: UIButton) {
        guard let inputText = txtinput.text, let inputValue = Double(inputText) else {
            lbloutput.text = "Invalid input"
            return
        }
        
        let convertedValue = calculateMagnitude(input: inputValue, unitTag: sender.tag)
        lbloutput.text = String(format: "%.2f", convertedValue)
    }

    // MARK: - Magnitude Calculation Logic
    func calculateMagnitude(input: Double, unitTag: Int) -> Double {
        switch unitTag {
        case 1:
            return convertToNewtons(input: input)
        case 2:
            return convertToPounds(input: input)
        case 3:
            return convertToMeters(input: input)
        case 4:
            return convertToFeet(input: input)
        case 5:
            return convertToKilograms(input: input)
        case 6:
            return convertToGrams(input: input)
        default:
            return input
        }
    }

    // MARK: - Conversion Functions
    func convertToNewtons(input: Double) -> Double {
        return input * 1.0
    }

    func convertToPounds(input: Double) -> Double {
        return input * 0.224809
    }

    func convertToMeters(input: Double) -> Double {
        return input * 1.0
    }

    func convertToFeet(input: Double) -> Double {
        return input * 3.28084
    }

    func convertToKilograms(input: Double) -> Double {
        return input * 1.0
    }

    func convertToGrams(input: Double) -> Double {
        return input * 1000.0
    }
}
