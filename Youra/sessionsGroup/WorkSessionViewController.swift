//
//  WorkSessionViewController.swift
//  Youra
//
//  Created by Stephen Giovanni Saputra on 09/04/22.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate Data
        backgrounds = BackgroundSeeder().generateData()
        quotes = BackgroundSeeder().generateQuotes()
        
        // Set View
        randomizeNumber()
        
        timerLabel.text = "WORK"
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
    }
    
    func randomizeNumber() {

        randNumber = Int(arc4random_uniform(6))
        quotesRandNumber = Int(arc4random_uniform(6))
    }
    
    func playAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 60
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
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
            })
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { action in
            })
        )
        
        present(alert, animated: true)
    }
}
