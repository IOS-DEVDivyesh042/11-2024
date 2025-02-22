import UIKit

class FeedbackVC: UIViewController {

    @IBOutlet weak var txtFeedback: UITextView!
    @IBOutlet weak var btnshare: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the text view
        txtFeedback.layer.borderColor = UIColor.black.cgColor
        txtFeedback.layer.borderWidth = 1
        txtFeedback.layer.cornerRadius = 20

        // Set up keyboard with done button
        setupKeyboard()
    }

    // MARK: - Setup Keyboard and Done Button
    func setupKeyboard() {
        // Add the "Done" button toolbar to the keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]
        txtFeedback.inputAccessoryView = toolbar

        // Dismiss keyboard when tapping outside the text view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func doneButtonTapped() {
        // Dismiss the keyboard
        txtFeedback.resignFirstResponder()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss keyboard when tapping outside
    }

    // MARK: - Button Actions
    @IBAction func btnShare(_ sender: UIButton) {
        if (txtFeedback.text!.count == 0) {
            let alert = UIAlertController(title: "Alert", message: "Invalid Input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in

            }))
            self.present(alert, animated: true)
        } else {
            txtFeedback.text = ""
            let alert = UIAlertController(title: "Thanks", message: "Your Feedback Sent Successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
}
