//
//  ViewController.swift
//  Youra
//
//  Created by Hansel Matthew on 04/04/22.
//

import UIKit

class homeViewController: UIViewController {
    
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!

    var workDuration: TimeInterval? = 0
    var restDuration: TimeInterval? = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home Screen Loaded")

        //Set Display Name
        usernameLabel.text = UserDefaultManager.shared.defaults.value(forKey: "username") as? String
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.funcName), name: NSNotification.Name(rawValue: "pickerClosed"), object: nil)
        
        updateLabel()
    }
    
    @objc func funcName() {
      updateLabel()
    }
    

    @IBAction func editWorkSession(_ sender: UIButton) {
        let vc = CustomModalViewController()
        vc.parentButton = "work"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }

    @IBAction func editRestSession(_ sender: UIButton) {
        let vc = CustomModalViewController()
        vc.parentButton = "rest"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String{
        
        let timeint = Int(interval)
        let timeStringed = String(timeint/60)
        
        return String(timeStringed)
    }
    
    func updateLabel(){
        workDuration = UserDefaultManager.shared.defaults.value(forKey: "workSession") as? TimeInterval
        restDuration = UserDefaultManager.shared.defaults.value(forKey: "restSession") as? TimeInterval

        workLabel.text = stringFromTimeInterval(interval: workDuration!)
        restLabel.text = stringFromTimeInterval(interval: restDuration!)
    }
}
