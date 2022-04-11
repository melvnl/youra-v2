//
//  PrivacyPolicyViewController.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 09/04/22.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var btnNext: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func saveUsername() {
        
    }

}

