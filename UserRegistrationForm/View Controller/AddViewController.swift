//
//  AddViewController.swift
//  iOSTechnicalAssessment
//
//  Created by Talor Levy on 2/16/23.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
        
    var delegate: SendNewUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - @IBAction

    @IBAction func saveButtonAction(_ sender: Any) {
        if (firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || usernameTextField.text == "") {
            let alertController = UIAlertController(title: "Warning", message: "You must complete all fields to save!", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true,completion: nil)
        } else {
            if let delegateValue = delegate {
                let firstName = firstNameTextField.text ?? ""
                let lastName = lastNameTextField.text ?? ""
                let email = emailTextField.text ?? ""
                let username = usernameTextField.text ?? ""
                delegateValue.sendNewUser(firstName: firstName, lastName: lastName, email: email, username: username)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}


// MARK: - SendNewUser

protocol SendNewUser {
    func sendNewUser(firstName: String, lastName: String, email: String, username: String)
}
