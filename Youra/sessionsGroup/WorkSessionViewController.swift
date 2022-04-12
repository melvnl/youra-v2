//
//  WorkSessionViewController.swift
//  Youra
//
//  Created by Stephen Giovanni Saputra on 09/04/22.
//

import UIKit
import AVFoundation

class WorkSessionViewController: UIViewController {
    
    var backgrounds: [Background] = []
    var quotes: [Quote] = []
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var endSessionButton: UIButton!
    @IBOutlet weak var quotesLabel: UILabel!
    
    let foregroundLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    var randNumber: Int = 0
    var quotesRandNumber: Int = 0
    var workDuration: TimeInterval? = 0
    
    var sessionDuration = Int((UserDefaultManager.shared.defaults.value(forKey: "workSession") as? TimeInterval)! )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate Data
        backgrounds = BackgroundSeeder().generateData()
        quotes = BackgroundSeeder().generateQuotes()
        workDuration = UserDefaultManager.shared.defaults.value(forKey: "workSession") as? TimeInterval
        
        // Set View
        randomizeNumber()
        
        let hours = sessionDuration / 3600
        let mins = sessionDuration % 3600 / 60
        let secs = sessionDuration % 60
        
        timerLabel.text = "\(workDuration ?? 0)"
        if(hours > 0){
            print("dari set view")
            print(hours)
            timerLabel.text = String(hours) + ":" + (mins >= 10 ? String(mins): ("0" + String(mins)) ) + ":" + (secs == 0 ? "00":String(secs))
        }
        else{
            timerLabel.text = String(mins) + ":" + (secs < 10 ? "0" : "") + String(secs)
        }
        
        
        timerLabel.textColor = backgrounds[randNumber].timerLabelColor
        
        imageBackground.image = backgrounds[randNumber].bgTitle
        
        quotesLabel.text = quotes[quotesRandNumber].quote
        
        endSessionButton.layer.shadowColor = UIColor.black.cgColor
        endSessionButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        endSessionButton.layer.shadowRadius = 5
        endSessionButton.layer.shadowOpacity = 0.2
        
        circularView.layer.cornerRadius = circularView.frame.size.width/2
        circularView.clipsToBounds = true
        circularView.backgroundColor = backgrounds[randNumber].circularViewColor
        
        // Circular Timer Progress
        let center = circularView.center
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: 160,
            startAngle: -CGFloat.pi / 2,
            endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi,
            clockwise: true)
        
        // Progress Bar
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 5
        backgroundLayer.strokeColor = backgrounds[randNumber].backgroundLayerColor.cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.lineWidth = 5
        foregroundLayer.strokeColor = backgrounds[randNumber].foregroundLayerColor.cgColor
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeEnd = 0
        
        view.layer.addSublayer(foregroundLayer)
        
        playAnimation()
        
        //set work label timer
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func randomizeNumber() {

        randNumber = Int(arc4random_uniform(6))
        quotesRandNumber = Int(arc4random_uniform(6))
    }
    
    func playAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = workDuration ?? 0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
   @objc func timerCount() {
       
       let hours = sessionDuration / 3600
       let mins = sessionDuration % 3600 / 60
       let secs = sessionDuration % 60
        
       if sessionDuration > 0 {
           sessionDuration -= 1
           
           if(hours > 0){
               timerLabel.text = String(hours) + ":" + (mins >= 10 ? String(mins): ("0" + String(mins)) ) + ":" + (secs == 0 ? "00":String(secs))
           }
           else{
               timerLabel.text = String(mins) + ":" + (secs < 10 ? "0" : "") + String(secs)
           }
           
           }
    }
    
    @IBAction func endSessionTapped(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: "End work session?",
            message: "You will end session earlier than the duration you have set up.",
            preferredStyle: .alert
        )
        
        alert.view.tintColor = UIColor(red: 50/255, green: 32/255, blue: 117/255, alpha: 1)
        
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .default,
            handler: { action in
                
                self.randomizeNumber()
                
                self.imageBackground.image = self.backgrounds[self.randNumber].bgTitle
                self.circularView.backgroundColor = self.backgrounds[self.randNumber].circularViewColor
                self.backgroundLayer.strokeColor = self.backgrounds[self.randNumber].backgroundLayerColor.cgColor
                self.foregroundLayer.strokeColor = self.backgrounds[self.randNumber].foregroundLayerColor.cgColor
                self.timerLabel.textColor = self.backgrounds[self.randNumber].timerLabelColor
                self.quotesLabel.text = self.quotes[self.quotesRandNumber].quote
                self.playAnimation()
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "sessionScreen", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "restView") as! RestSessionViewController
                self.present(nextViewController, animated:true, completion:nil)
            })
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .destructive,
            handler: { action in
            })
        )
        
        present(alert, animated: true)
    }
}
