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

	let context = (UIApplication.self.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home Screen Loaded")
        
        let date = Date()
        let hour = (Calendar.current.component(.hour, from: date))
        
        switch hour {
          case 5...11:
            goodLabel.text = "Good Morning, "

          case 12...17:
            goodLabel.text = "Good Afternoon, "

          default:
            goodLabel.text = "Good Evening, "
        }
        
        usernameLabel.text = UserDefaultManager.shared.defaults.value(forKey: "username") as? String
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.funcName), name: NSNotification.Name(rawValue: "pickerClosed"), object: nil)
        
        updateLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workTime = Int((UserDefaultManager.shared.defaults.value(forKey: "workSession") as? TimeInterval) ?? 0 )
        
        let restTime = Int((UserDefaultManager.shared.defaults.value(forKey: "restSession") as? TimeInterval) ?? 0 )
        
        if(workTime == 0 || restTime == 0) {
            showAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: "Empty Session!",
            message: "Select your work and rest duration",
            preferredStyle: .alert
        )
        
        alert.view.tintColor = UIColor(red: 50/255, green: 32/255, blue: 117/255, alpha: 1)
        
        alert.addAction(UIAlertAction(
            title: "Close",
            style: .destructive,
            handler: { action in
            })
        )
        
        present(alert, animated: true)
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


	@IBAction func startButtonClick(_ sender: Any) {
		let sessionData = SessionData(context: self.context)
		sessionData.key = generateKey(len: 10)
		sessionData.createDate = Date()

		AppHelper.initSessionData(sessionData: sessionData)
//		print(AppHelper.getSessionData())
	}

	func generateKey(len:Int) -> String {
		let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let c = Array(charSet)
		var s:String = ""
		for _ in (1...10) {
			s.append(c[Int(arc4random()) % c.count])
		}
		return s
	}
}
