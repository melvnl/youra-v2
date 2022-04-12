//
//  RestSessionViewController.swift
//  Youra
//
//  Created by Stephen Giovanni Saputra on 10/04/22.
//

import UIKit
import AVFoundation

class RestSessionViewController: UIViewController {
    
    var backgrounds: [Background] = []
    var quotes: [Quote] = []
    var musics: [Music] = []
    var song = AVAudioPlayer()
    
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var restTimerLabel: UILabel!
    @IBOutlet weak var endRestSessionButton: UIButton!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var noteBGButton: UIView!
    @IBOutlet weak var noteButton: UIButton!
    
    let foregroundLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    var randNumber: Int = 1
    var quotesRandNumber: Int = 0
    var musicRandNumber: Int = 0
    var isPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate Data from Seeder
        backgrounds = BackgroundSeeder().generateData()
        quotes = BackgroundSeeder().generateQuotes()
        musics = MusicSeeder().generateData()
        
        // Set View
        randomizeNumber()
        
        restTimerLabel.text = "REST"
        restTimerLabel.textColor = backgrounds[randNumber].timerLabelColor
        
        imageBackground.image = backgrounds[randNumber].bgTitle
        
        quotesLabel.text = quotes[quotesRandNumber].quote
        
        pauseButton.tintColor = backgrounds[randNumber].pauseButtonColor
        
        noteButton.tintColor = backgrounds[randNumber].noteIconColor
        
        endRestSessionButton.layer.shadowColor = UIColor.black.cgColor
        endRestSessionButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        endRestSessionButton.layer.shadowRadius = 5
        endRestSessionButton.layer.shadowOpacity = 0.2
        
        circularView.layer.cornerRadius = circularView.frame.size.width/2
        circularView.clipsToBounds = true
        circularView.backgroundColor = backgrounds[randNumber].circularViewColor
        
        noteBGButton.layer.cornerRadius = noteBGButton.frame.size.width/2
        noteBGButton.clipsToBounds = true
        noteBGButton.backgroundColor = backgrounds[randNumber].noteButtonBGColor
        
        // Circular Timer Progress
        let center = circularView.center
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: 160,
            startAngle: -CGFloat.pi / 2,
            endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi,
            clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 5
        backgroundLayer.strokeColor = backgrounds[randNumber].backgroundLayerColor.cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(backgroundLayer)
        
        // Progress nya
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.lineWidth = 5
        foregroundLayer.strokeColor = backgrounds[randNumber].foregroundLayerColor.cgColor
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeEnd = 0
        
        view.layer.addSublayer(foregroundLayer)
        
        playAnimation()
        playSong()
        song.play()
    }
    
    @IBAction func noteButtonPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        
        if song.isPlaying {
            
            song.pause()
            isPaused = true
            pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            
            song.play()
            isPaused = false
            pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func playSong() {
        
        do {
            
            song = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: musics[musicRandNumber].title, ofType: "mp3")!))
            
            song.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                
                try audioSession.setCategory(AVAudioSession.Category.playback)
                
            } catch let sessionError {
                
                print(sessionError)
            }
            
        } catch let songPlayerError {
            print(songPlayerError)
        }
    }
    
    func randomizeNumber() {
        
        randNumber = Int(arc4random_uniform(6))
        quotesRandNumber = Int(arc4random_uniform(6))
        musicRandNumber = Int(arc4random_uniform(6))
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
            title: "End rest session?",
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
                self.restTimerLabel.textColor = self.backgrounds[self.randNumber].timerLabelColor
                self.quotesLabel.text = self.quotes[self.quotesRandNumber].quote
                self.pauseButton.tintColor = self.backgrounds[self.randNumber].pauseButtonColor
                self.noteButton.tintColor = self.backgrounds[self.randNumber].noteIconColor
                self.noteBGButton.backgroundColor = self.backgrounds[self.randNumber].noteButtonBGColor
                self.playAnimation()
                self.playSong()
                self.song.play()
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
