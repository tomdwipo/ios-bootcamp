//
//  ForgotViewController.swift
//  Login
//
//  Created by Bayu Yasaputro on 06/10/21.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    var email: String?
    
    // MARK: - Lifecyclle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1. viewDidLoad")

        // Do any additional setup after loading the view.
        emailTextField.text = email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4. viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5. viewDidDisappear")
    }
    
    deinit {
        print("6. deinit")
    }
    
    // MARK: - Actions
    
//    @IBAction func closeButtonTapped(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Extensions
extension UIViewController {
    func showForgotViewController(email: String? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "forgot") as! ForgotViewController
        viewController.email = email
        
//        present(viewController, animated: true, completion: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
