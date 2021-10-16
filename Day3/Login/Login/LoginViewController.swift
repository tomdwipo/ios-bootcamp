//
//  LoginViewController.swift
//  Login
//
//  Created by Bayu Yasaputro on 04/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: cardView.centerXAnchor, constant: 0)
        ])
    }
    
    // MARK: - Actions
    
    @objc func registerButtonTapped(_ sender: Any) {
        print("Register")
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let validation = validate()
        if validation.isValid {
            login()
        }
        else {
            let alert = UIAlertController(title: "Error", message: validation.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func forgotButtonTapped(_ sender: Any) {
        showForgotViewController(email: emailTextField.text)
    }
    
    // MARK: - Helpers
    
    func validate() -> (isValid: Bool, message: String) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            return (false, "Email tidak boleh kosong")
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            return (false, "Password tidak boleh kosong")
        }
        
        return (true, "")
    }
    
    func login() {
        view.endEditing(true)
        print("Login berhasil")
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            textField.resignFirstResponder()
            login()
            
        default:
            break
        }
        
        return false
    }
}
