//
//  PrivacyPolicyViewController.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 09/04/22.
//

import UIKit

class PrivacyPolicyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var btnNext: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTF.delegate = self
        overrideUserInterfaceStyle = .light
        
        configureTextFieldObservers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return textField.endEditing(false)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func usernameChange(_ sender: Any) {
        if let username = usernameTF.text {
            if let errorMessage = invalidUsername(username) {
                usernameErrorLabel.text = errorMessage
                usernameErrorLabel.isHidden = false
            }
            else {
                usernameErrorLabel.isHidden = true
            }
        }
        checkValidation()
    }

    @IBAction func nextBtnClick() {
        
        UserDefaultManager.shared.defaults.setValue(usernameTF.text, forKey: "username")
    }

    func invalidUsername(_ value: String) -> String? {
        let predicate = NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z ].*")

        if predicate.evaluate(with: value) { return "The name may only contain letters & spaces" }
        if value.count <= 0 { return "Name cannot be blank" }
		if value.count < 3 { return "Min 3 characters" }
		if value.count > 16 { return "Max 16 characters" }
        return nil
    }

    func checkValidation() {
        if usernameErrorLabel.isHidden == true && usernameTF.text != "" {
            btnNext.isEnabled = true
        }
        else {
            btnNext.isEnabled = false
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = view.frame.height - (usernameTF.frame.origin.y + usernameTF.frame.height)
            view.frame.origin.y -= keyboardHeight - bottomSpacing + 50
        }
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTF.resignFirstResponder()
    }
    
    func configureTextFieldObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
}

