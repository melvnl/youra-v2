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
    var workDuration = Int((UserDefaultManager.shared.defaults.value(forKey: "workSession") as? TimeInterval) ?? 0 )
    
    var timer: Timer!
    
    
    override func viewDidLoad() {
        
        print(circularView.frame.height)
        print(circularView.frame.width)
        
        super.viewDidLoad()
        
        // Generate Data
        backgrounds = BackgroundSeeder().generateData()
        quotes = BackgroundSeeder().generateQuotes()
        
        // Set View
        randomizeNumber()
        
        let hours = workDuration / 3600
        let mins = workDuration % 3600 / 60
        let secs = workDuration % 60
        
        timerLabel.text = "\(workDuration)"
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
        
        circularView.frame.size.width = view.frame.width - 110
        circularView.frame.size.height = view.frame.width - 110
        circularView.layer.cornerRadius = circularView.frame.width / 2
        circularView.clipsToBounds = true
        circularView.backgroundColor = backgrounds[randNumber].circularViewColor
        
        // Circular Timer Progress
        let center = circularView.center
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: (circularView.frame.size.height / 2) + 20,
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
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
        basicAnimation.duration = Double(workDuration) + 0.9
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    @objc func timerCount() {
        
        let hours = workDuration / 3600
        let mins = workDuration % 3600 / 60
        let secs = workDuration % 60
        
        if workDuration > 0 {
            workDuration -= 1
            
            if hours > 0 {
                timerLabel.text = String(hours) + ":" + (mins >= 10 ? String(mins): ("0" + String(mins)) ) + ":" + (secs == 0 ? "00":String(secs))
            } else {
                timerLabel.text = String(mins) + ":" + (secs < 10 ? "0" : "") + String(secs)
            }
        }
        else  {
            timer.invalidate()
            let sessionData = AppHelper.getSessionData()
            sessionData.workDuration = getWorkDuration()
            
            AppHelper.initSessionData(sessionData: sessionData)
            print("Work Session")
            print(AppHelper.getSessionData())
            
            self.performSegue(withIdentifier: "workMoodSegue", sender: nil)
        }
    }
    
    @IBAction func endSessionTapped(_ sender: Any) {
        
        showAlert()
        
        let sessionData = AppHelper.getSessionData()
        sessionData.workDuration = getWorkDuration()
        
        AppHelper.initSessionData(sessionData: sessionData)
        print("Work Session")
        print(AppHelper.getSessionData())
    }
    
    func getWorkDuration() -> Double {
        return Double(UserDefaultManager.shared.defaults.value(forKey: "workSession") as! Int - workDuration)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: "End work session?",
            message: "You will end session earlier than the duration you have set up.",
            preferredStyle: .alert
        )
        
        alert.view.tintColor = UIColor(named: "alert")
        
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .default,
            handler: { action in
                
                self.performSegue(withIdentifier: "workMoodSegue", sender: nil)
                self.timer.invalidate()
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
