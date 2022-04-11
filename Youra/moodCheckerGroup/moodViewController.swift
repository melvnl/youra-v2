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
    
    @IBAction func getSliderValue(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        
        if(currentValue >= 0.75){
            let image = UIImage(named:"emoji 4.png")
            emoji.image = image
            moodLabel.text = "Very Good"
        }
        else if(currentValue >= 0.5){
            let image = UIImage(named:"emoji 3.png")
            emoji.image = image
            moodLabel.text = "Good"
        }
        else if(currentValue >= 0.25){
            let image = UIImage(named:"emoji 2.png")
            emoji.image = image
            moodLabel.text = "Bad"
        }
        else{
            let image = UIImage(named:"emoji 1.png")
            emoji.image = image
            moodLabel.text = "Very Bad"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
