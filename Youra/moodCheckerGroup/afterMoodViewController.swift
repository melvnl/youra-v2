//
//  afterMoodViewController.swift
//  Youra
//
//  Created by Hansel Matthew on 12/04/22.
//

import UIKit

class afterMoodViewController: UIViewController {

    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var moodLabel: UILabel!

	let context = (UIApplication.self.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var sliderValue:Float = 0.0
    
    @IBOutlet weak var button: UIButton!
    @IBAction func getSliderValue(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        
        if(currentValue >= 0.75){
            let image = UIImage(named:"emoji 4.png")
            emoji.image = image
            moodLabel.text = "Refreshed and happy"
        }
        else if(currentValue >= 0.5){
            let image = UIImage(named:"emoji 3.png")
            emoji.image = image
            moodLabel.text = "I’m fine"
        }
        else if(currentValue >= 0.25){
            let image = UIImage(named:"emoji 2.png")
            emoji.image = image
            moodLabel.text = "Not okay"
        }
        else{
            let image = UIImage(named:"emoji 1.png")
            emoji.image = image
            moodLabel.text = "Very Bad"
        }

		sliderValue = currentValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                button.layer.shadowOffset = CGSize(width: 0, height: 3)
                button.layer.shadowOpacity = 1.0
                button.layer.shadowRadius = 10.0
                button.layer.masksToBounds = false
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

	@IBAction func finishButtonClick(_ sender: Any) {
		let sessionData = AppHelper.getSessionData()
		sessionData.moodAfter = sliderValue
		sessionData.endDate = Date()

		AppHelper.initSessionData(sessionData: sessionData)
		print("After Mood")
		print(AppHelper.getSessionData())

		saveSessionData()
	}

	func saveSessionData() {
		_ = AppHelper.getSessionData()
		do {
			try self.context.save()
		} catch {

		}
		var data:[SessionData] = []
		do {
			data = try context.fetch(SessionData.fetchRequest())
		} catch {

		}

		print("Core Data Value")
		print(data)
	}
}
