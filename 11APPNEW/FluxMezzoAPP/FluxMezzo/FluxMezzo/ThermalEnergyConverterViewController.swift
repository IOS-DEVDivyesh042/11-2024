import UIKit

@available(iOS 13.0, *)
class ThermalEnergyConverterViewController: UIViewController {
    
    let inputTextFieldMass: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter mass (kg)"
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
    
    let inputTextFieldSpecificHeat: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter specific heat (J/kg°C)"
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
    
    let inputTextFieldTemperatureChange: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter temperature change (°C)"
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
        button.addTarget(self, action: #selector(calculateThermalEnergy), for: .touchUpInside)
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
        view.addSubview(inputTextFieldMass)
        view.addSubview(inputTextFieldSpecificHeat)
        view.addSubview(inputTextFieldTemperatureChange)
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
        inputTextFieldMass.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldSpecificHeat.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldTemperatureChange.translatesAutoresizingMaskIntoConstraints = false
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel1.translatesAutoresizingMaskIntoConstraints = false
        resultLabel2.translatesAutoresizingMaskIntoConstraints = false
        resultLabel3.translatesAutoresizingMaskIntoConstraints = false
        resultLabel4.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        // AutoLayout Constraints
        NSLayoutConstraint.activate([
            // Mass Input TextField constraints
            inputTextFieldMass.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            inputTextFieldMass.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldMass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldMass.heightAnchor.constraint(equalToConstant: 50),
            
            // Specific Heat Input TextField constraints
            inputTextFieldSpecificHeat.topAnchor.constraint(equalTo: inputTextFieldMass.bottomAnchor, constant: 20),
            inputTextFieldSpecificHeat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldSpecificHeat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldSpecificHeat.heightAnchor.constraint(equalToConstant: 50),
            
            // Temperature Change Input TextField constraints
            inputTextFieldTemperatureChange.topAnchor.constraint(equalTo: inputTextFieldSpecificHeat.bottomAnchor, constant: 20),
            inputTextFieldTemperatureChange.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldTemperatureChange.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldTemperatureChange.heightAnchor.constraint(equalToConstant: 50),
            
            // Convert Button constraints
            convertButton.topAnchor.constraint(equalTo: inputTextFieldTemperatureChange.bottomAnchor, constant: 20),
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
            loaderView.widthAnchor.constraint(equalToConstant: 150),
            loaderView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func calculateThermalEnergy() {
        guard let massText = inputTextFieldMass.text, let mass = Double(massText),
              let specificHeatText = inputTextFieldSpecificHeat.text, let specificHeat = Double(specificHeatText),
              let temperatureChangeText = inputTextFieldTemperatureChange.text, let temperatureChange = Double(temperatureChangeText) else {
            return
        }
        
        loaderView.isHidden = false
        
        // Simulate a delay for calculation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let thermalEnergy = mass * specificHeat * temperatureChange // in Joules
            
            // Display results with 2 decimal places
            self.resultLabel1.text = String(format: "Thermal Energy: %.2f J", thermalEnergy)
            self.resultLabel2.text = String(format: "Thermal Energy: %.2f kJ", thermalEnergy / 1000)
            self.resultLabel3.text = String(format: "Thermal Energy: %.2f cal", thermalEnergy / 239)
            self.resultLabel4.text = String(format: "Thermal Energy: %.2f BTU", thermalEnergy * 9.48e-4) // Convert to BTU
            
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
            self.loaderView.isHidden = true
            self.inputTextFieldMass.text = ""
            self.inputTextFieldSpecificHeat.text = ""
            self.inputTextFieldTemperatureChange.text = ""
            self.resultLabel1.text = ""
            self.resultLabel2.text = ""
            self.resultLabel3.text = ""
            self.resultLabel4.text = ""
        }
    }

    static func createResultLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowRadius = 2
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
        inputTextFieldMass.inputAccessoryView = toolbar
        inputTextFieldSpecificHeat.inputAccessoryView = toolbar
        inputTextFieldTemperatureChange.inputAccessoryView = toolbar
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
}
