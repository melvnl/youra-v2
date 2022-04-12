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
    @IBOutlet weak var goodLabel: UILabel!
    
    var workDuration: TimeInterval? = 0
    var restDuration: TimeInterval? = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home Screen Loaded")
        
        let date = Date()
        let hour = (Calendar.current.component(.hour, from: date))
        
        switch hour {
          case 5...11:
            goodLabel.text = "Good Morning"

          case 12...17:
            goodLabel.text = "Good Afternoon"

          default:
            goodLabel.text = "Good Evening"
        }
        
        usernameLabel.text = UserDefaultManager.shared.defaults.value(forKey: "username") as? String
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.funcName), name: NSNotification.Name(rawValue: "pickerClosed"), object: nil)
        
        updateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

        workLabel.text = stringFromTimeInterval(interval: workDuration ?? 0)
        restLabel.text = stringFromTimeInterval(interval: restDuration ?? 0)
    }
}
