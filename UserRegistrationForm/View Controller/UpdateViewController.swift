//
//  UpdateViewController.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/19/23.
//

import UIKit

class UpdateViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var delegate: SendUpdatedUser?
    var user: User = User()
    var creationTime: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    func loadUserData() {
        firstNameTextField.text = user.firstName ?? ""
        lastNameTextField.text = user.lastName ?? ""
        emailTextField.text = user.email ?? ""
        usernameTextField.text = user.username ?? ""
        creationTime = user.creationTime ?? Date()
    }
    
    // MARK: - @IBAction

    @IBAction func updateButtonAction(_ sender: Any) {
        if let delegateValue = delegate {
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let username = usernameTextField.text ?? ""
            delegateValue.sendUpdatedUser(user: user, firstName: firstName, lastName: lastName, email: email, username: username, creationTime: creationTime)
        }
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - SendUpdatedUser

protocol SendUpdatedUser {
    func sendUpdatedUser(user: User, firstName: String, lastName: String, email: String, username: String, creationTime: Date)
}
