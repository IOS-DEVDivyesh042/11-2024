import UIKit

@available(iOS 13.0, *)
class SolarEnergyConverterViewController: UIViewController {
    
    // Input text fields for panel area, solar irradiance, and efficiency
    let inputTextFieldArea: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter panel area (m²)"
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
    
    let inputTextFieldIrradiance: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter solar irradiance (W/m²)"
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
    
    let inputTextFieldEfficiency: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter efficiency (%)"
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOpacity = 0.7
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowRadius = 5
        textField.keyboardType = .numberPad  //
        textField.textAlignment = .center
        return textField
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(calculateSolarEnergy), for: .touchUpInside)
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
        view.addSubview(inputTextFieldArea)
        view.addSubview(inputTextFieldIrradiance)
        view.addSubview(inputTextFieldEfficiency)
        view.addSubview(convertButton)
        view.addSubview(clearButton)
        view.addSubview(resultLabel1)
        view.addSubview(resultLabel2)
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
        inputTextFieldArea.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldIrradiance.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldEfficiency.translatesAutoresizingMaskIntoConstraints = false
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel1.translatesAutoresizingMaskIntoConstraints = false
        resultLabel2.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        // AutoLayout Constraints
        NSLayoutConstraint.activate([
            // Area Input TextField constraints
            inputTextFieldArea.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            inputTextFieldArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldArea.heightAnchor.constraint(equalToConstant: 50),
            
            // Irradiance Input TextField constraints
            inputTextFieldIrradiance.topAnchor.constraint(equalTo: inputTextFieldArea.bottomAnchor, constant: 20),
            inputTextFieldIrradiance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldIrradiance.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldIrradiance.heightAnchor.constraint(equalToConstant: 50),
            
            // Efficiency Input TextField constraints
            inputTextFieldEfficiency.topAnchor.constraint(equalTo: inputTextFieldIrradiance.bottomAnchor, constant: 20),
            inputTextFieldEfficiency.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldEfficiency.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldEfficiency.heightAnchor.constraint(equalToConstant: 50),
            
            // Convert Button constraints
            convertButton.topAnchor.constraint(equalTo: inputTextFieldEfficiency.bottomAnchor, constant: 20),
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
            
            // Loader view
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 200),
            loaderView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func calculateSolarEnergy() {
        guard let areaText = inputTextFieldArea.text, let area = Double(areaText),
              let irradianceText = inputTextFieldIrradiance.text, let irradiance = Double(irradianceText),
              let efficiencyText = inputTextFieldEfficiency.text, let efficiency = Double(efficiencyText) else {
            return
        }
        
        loaderView.isHidden = false
        
        // Simulate a delay for calculation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Calculate energy in Megajoules
            let energyMJ = area * irradiance * efficiency / 100.0 * 3600 // Convert to MJ
            let energyKWh = energyMJ / 3.6 // Convert to kWh
            
            self.resultLabel1.text = String(format: "Energy: %.2f MJ", energyMJ)
            self.resultLabel2.text = String(format: "Energy: %.2f kWh", energyKWh)
            self.loaderView.isHidden = true
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
            self.inputTextFieldArea.text = ""
            self.inputTextFieldIrradiance.text = ""
            self.inputTextFieldEfficiency.text = ""
            self.resultLabel1.text = "Energy: "
            self.resultLabel2.text = "Energy: "
        }
    }
    
    static func createResultLabel() -> UILabel {
        let label = UILabel()
        label.text = "Energy: "
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
        inputTextFieldArea.inputAccessoryView = toolbar
        inputTextFieldIrradiance.inputAccessoryView = toolbar
        inputTextFieldEfficiency.inputAccessoryView = toolbar
        
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}

// In your AppDelegate or SceneDelegate
// window?.rootViewController = SolarEnergyConverterViewController()
