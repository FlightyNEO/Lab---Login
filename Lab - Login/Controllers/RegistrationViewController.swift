//
//  RegistrationViewController.swift
//  Lab - Login
//
//  Created by Arkadiy Grigoryanc on 04/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Private properties
    private let segueSignInIdentifier = "SignIn"
    private let segueSignOutIdentifier = "SignOut"
    
    // MARK: - Outlets
    @IBOutlet weak var authView: UIStackView!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var helpTextView: UITextView!
    
    // MARK: - Life cicles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set data
        FakePersons.forEach { helpTextView.text.append($0.description) }
        infoLabel.text = nil
        eMailTextField.text = FakePersons.first?.eMail
        passwordTextField.text = FakePersons.first?.password
        
        // Add keyboard notifikations
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    // MARK: - Private methods
    private func checkAuth() -> Bool {
        
        return FakePersons.contains { (person) -> Bool in
            return person.eMail == eMailTextField.text && person.password == passwordTextField.text
        }
        
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Alert",
                                                message: "eMail и/или password не верный. Или поле/поля пустые. Внизу приведены возможные варианты",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func showKeyboard(_ notification: NSNotification) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        
                        let keyboardRect = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                        
                        if keyboardRect.minY <= self.authView.frame.minY + self.passwordTextField.frame.maxY {
                            let offsetY = self.authView.frame.minY + self.passwordTextField.frame.maxY - keyboardRect.minY
                            self.authView.transform = CGAffineTransform(translationX: 0, y: -offsetY - 10)
                            
                        }
        })
        
    }
    
    @objc private func hideKeyboard() {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                            self.authView.transform = CGAffineTransform.identity
        })
        
    }
    
    // MARK: - Actions
    @IBAction func actionSignIn() {
        
        guard checkAuth() else { showAlert(); return }
        
        performSegue(withIdentifier: "SignIn", sender: nil)
        
    }
    
    @IBAction func actionSignOut(segue: UIStoryboardSegue) {
        guard segue.identifier == segueSignOutIdentifier else { return }
        let profileVC = segue.source as! ProfileViewController
        infoLabel.text = "\(profileVC.name!)" + " вышел из системы"
//        eMailTextField.text = nil
//        passwordTextField.text = nil
        
    }
    
}

// MARK: - Navigation
extension RegistrationViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == segueSignInIdentifier else { return }
        let profileVC = segue.destination as! ProfileViewController
        profileVC.name = FakePersons.first { $0.eMail == eMailTextField.text }?.name
        profileVC.eMail = eMailTextField.text
        profileVC.password = passwordTextField.text
        
    }
    
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let eMail = eMailTextField.text, !eMail.isEmpty else { return false }
        guard let pass = passwordTextField.text, !pass.isEmpty else { return false }
        
        textField.resignFirstResponder()
        actionSignIn()
        
        return true
    }
    
}
