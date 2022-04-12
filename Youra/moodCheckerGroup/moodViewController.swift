//
//  moodViewController.swift
//  Youra
//
//  Created by melvin on 11/04/22.
//

import UIKit

class moodViewController: UIViewController {

    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var moodLabel: UILabel!
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
