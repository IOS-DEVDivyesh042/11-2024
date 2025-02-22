import UIKit

@available(iOS 13.0, *)
class BiomassEnergyConverterViewController: UIViewController {
    
    // Input text fields for biomass mass and energy content
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
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let inputTextFieldEnergyContent: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter energy content (MJ/kg)"
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOpacity = 0.7
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowRadius = 5
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(calculateBiomassEnergy), for: .touchUpInside)
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
        view.addSubview(inputTextFieldMass)
        view.addSubview(inputTextFieldEnergyContent)
        view.addSubview(convertButton)
        view.addSubview(clearButton)
        view.addSubview(resultLabel1)
        view.addSubview(resultLabel2)
        view.addSubview(loaderView)
        
        // Set up constraints
        setUpConstraints()
        
        // Add "Done" button to the keyboard
        addDoneButtonToKeyboard()
        
        // Add tap gesture to dismiss the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.yellow.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor,
            UIColor.blue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setUpConstraints() {
        inputTextFieldMass.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldEnergyContent.translatesAutoresizingMaskIntoConstraints = false
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel1.translatesAutoresizingMaskIntoConstraints = false
        resultLabel2.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputTextFieldMass.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            inputTextFieldMass.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldMass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldMass.heightAnchor.constraint(equalToConstant: 50),
            
            inputTextFieldEnergyContent.topAnchor.constraint(equalTo: inputTextFieldMass.bottomAnchor, constant: 20),
            inputTextFieldEnergyContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputTextFieldEnergyContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputTextFieldEnergyContent.heightAnchor.constraint(equalToConstant: 50),
            
            convertButton.topAnchor.constraint(equalTo: inputTextFieldEnergyContent.bottomAnchor, constant: 20),
            convertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            convertButton.widthAnchor.constraint(equalToConstant: 150),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            
            clearButton.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 150),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel1.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 40),
            resultLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel1.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel2.topAnchor.constraint(equalTo: resultLabel1.bottomAnchor, constant: 20),
            resultLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel2.heightAnchor.constraint(equalToConstant: 50),
            
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 200),
            loaderView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func calculateBiomassEnergy() {
        guard let massText = inputTextFieldMass.text, let mass = Double(massText),
              let energyContentText = inputTextFieldEnergyContent.text, let energyContent = Double(energyContentText) else {
            return
        }
        
        loaderView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let biomassEnergy = mass * energyContent
            self.resultLabel1.text = String(format: "Biomass Energy: %.2f MJ", biomassEnergy)
            self.resultLabel2.text = String(format: "Biomass Energy: %.2f kWh", biomassEnergy * 0.277778)
            self.loaderView.isHidden = true
        }
    }
    
    @objc func clearFields() {
        if let loaderLabel = loaderView.subviews.first(where: { $0 is UILabel }) as? UILabel {
            loaderLabel.text = "Clearing..."
        }
        loaderView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loaderView.isHidden = true
            self.inputTextFieldMass.text = ""
            self.inputTextFieldEnergyContent.text = ""
            self.resultLabel1.text = ""
            self.resultLabel2.text = ""
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
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [doneButton]
        
        inputTextFieldMass.inputAccessoryView = toolbar
        inputTextFieldEnergyContent.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
