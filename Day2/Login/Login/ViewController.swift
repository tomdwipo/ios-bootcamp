//
//  ViewController.swift
//  Login
//
//  Created by Bayu Yasaputro on 04/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }

    func setup() {
        logoImageView.layer.cornerRadius = 50
        logoImageView.layer.masksToBounds = true
        
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        
        submitButton.layer.cornerRadius = 18
        submitButton.layer.masksToBounds = true
        
        
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
    
    func login() {
        print("Login berhasil")
    }
    
    func validate() -> (isValid: Bool, message: String) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return (false, "Email tidak boleh kosong")
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            return (false, "Password tidak boleh kosong")
        }
        
        return (true, "")
    }
    
}

