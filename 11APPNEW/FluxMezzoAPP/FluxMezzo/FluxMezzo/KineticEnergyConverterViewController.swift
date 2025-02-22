import UIKit

@available(iOS 13.0, *)
class KineticEnergyConverterViewController: UIViewController {
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter mass and velocity"
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOpacity = 0.7
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowRadius = 5
        textField.textAlignment = .center
        textField.keyboardType = .numberPad  //
        return textField
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(convertKineticEnergy), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(clearFields), for: .touchUpInside)
        return button
    }()
    
    let resultLabel1 = createResultLabel()
    let resultLabel2 = createResultLabel()
    let resultLabel3 = createResultLabel()
    let resultLabel4 = createResultLabel()
    
    let loaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.isHidden = true
        let loaderLabel = UILabel()
        loaderLabel.text = "Calculating..."
        loaderLabel.textColor = .white
        loaderLabel.textAlignment = .center
        view.addSubview(loaderLabel)
        loaderLabel.translatesAutoresizingMaskIntoConstraints = false
        loaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the gradient background
        setGradientBackground()
        
        // Add subviews
        view.addSubview(inputTextField)
        view.addSubview(convertButton)
        view.addSubview(clearButton)
        view.addSubview(resultLabel1)
        view.addSubview(resultLabel2)
        view.addSubview(resultLabel3)
        view.addSubview(resultLabel4)
        view.addSubview(loaderView)
        
        // Set up constraints
        setUpConstraints()
        
        addDoneButtonToKeyboard()
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Colors for each corner
        gradientLayer.colors = [
            UIColor.yellow.cgColor,  // Top-left
            UIColor.orange.cgColor,   // Top-right
            UIColor.red.cgColor,      // Bottom-left
            UIColor.blue.cgColor       // Bottom-right
        ]
        
        // Set color positions for each corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Top-left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)    // Bottom-right
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setUpConstraints() {
        // Disable autoresizing
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel1.translatesAutoresizingMaskIntoConstraints = false
        resultLabel2.translatesAutoresizingMaskIntoConstraints = false
        resultLabel3.translatesAutoresizingMaskIntoConstraints = false
        resultLabel4.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        // AutoLayout Constraints
        NSLayoutConstraint.activate([
            // Input TextField constraints
            inputTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Convert Button constraints
            convertButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            convertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            convertButton.widthAnchor.constraint(equalToConstant: 150),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Clear Button constraints
            clearButton.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 150),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Result Labels constraints
            resultLabel1.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 40),
            resultLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel1.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel2.topAnchor.constraint(equalTo: resultLabel1.bottomAnchor, constant: 20),
            resultLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel2.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel3.topAnchor.constraint(equalTo: resultLabel2.bottomAnchor, constant: 20),
            resultLabel3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel3.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel4.topAnchor.constraint(equalTo: resultLabel3.bottomAnchor, constant: 20),
            resultLabel4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel4.heightAnchor.constraint(equalToConstant: 50),
            
            // Loader view
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 200),
            loaderView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func convertKineticEnergy() {
        // Show the loader view
        loaderView.isHidden = false
        
        // Hide the loader and show results after a 4-second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.loaderView.isHidden = true
            
            // Assume a simple kinetic energy calculation for example purposes
            guard let inputText = self.inputTextField.text, let massVelocity = Double(inputText) else {
                return
            }
            
            let kineticEnergy = 0.5 * massVelocity * massVelocity
            
            self.resultLabel1.text = "Joules: \(kineticEnergy)"
            self.resultLabel2.text = "kJ: \(kineticEnergy / 1000)"
            self.resultLabel3.text = "Ergs: \(kineticEnergy * 1e7)"
            self.resultLabel4.text = "ft-lbs: \(kineticEnergy * 0.737562)"
        }
    }
    
    @objc func clearFields() {
        // Change loader label text to "Clearing..."
        if let loaderLabel = loaderView.subviews.first(where: { $0 is UILabel }) as? UILabel {
            loaderLabel.text = "Clearing..."
        }
        
        // Show the loader view
        loaderView.isHidden = false
        
        // Hide the loader and clear the fields after a 2-second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loaderView.isHidden = true
            self.inputTextField.text = ""
            self.resultLabel1.text = ""
            self.resultLabel2.text = ""
            self.resultLabel3.text = ""
            self.resultLabel4.text = ""
        }
    }


    
    static func createResultLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.systemGray5
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 5
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }
    
    func addDoneButtonToKeyboard() {
            // Create toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            // Create "Done" button
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
            
            // Add "Done" button to toolbar
            toolbar.items = [doneButton]
            
            // Attach toolbar to inputTextField
            inputTextField.inputAccessoryView = toolbar
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
}
