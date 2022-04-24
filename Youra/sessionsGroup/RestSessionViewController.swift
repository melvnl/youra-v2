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
    var restDuration = Int((UserDefaultManager.shared.defaults.value(forKey: "restSession") as? TimeInterval) ?? 0 )
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate Data from Seeder
        backgrounds = BackgroundSeeder().generateData()
        quotes = BackgroundSeeder().generateQuotes()
        musics = MusicSeeder().generateData()
        
        // Set View
        randomizeNumber()
        
        print(restDuration)
        
        let hours = restDuration / 3600
        let mins = restDuration % 3600 / 60
        let secs = restDuration % 60
        
        restTimerLabel.text = "\(restDuration)"
        if(hours > 0){
            print("dari set view")
            print(hours)
            restTimerLabel.text = String(hours) + ":" + (mins >= 10 ? String(mins): ("0" + String(mins)) ) + ":" + (secs == 0 ? "00":String(secs))
        }
        else{
            print(restDuration)
            restTimerLabel.text = String(mins) + ":" + (secs < 10 ? "0" : "") + String(secs)
        }
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
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
        
        playSong()
        song.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func noteButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        
        if song.isPlaying {
            
            song.pause()
            isPaused = true
            pauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else {
            
            song.play()
            isPaused = false
            pauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
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
        basicAnimation.duration = (Double(restDuration)) + 0.9
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    @objc func timerCount() {
        
        let hours = restDuration / 3600
        let mins = restDuration % 3600 / 60
        let secs = restDuration % 60
        
        if restDuration > 0 {
            restDuration -= 1
            
            if(hours > 0){
                restTimerLabel.text = String(hours) + ":" + (mins >= 10 ? String(mins): ("0" + String(mins)) ) + ":" + (secs == 0 ? "00":String(secs))
            }
            else{
                print(restDuration)
                restTimerLabel.text = String(mins) + ":" + (secs < 10 ? "0" : "") + String(secs)
            }
        }
        
        else {
            timer.invalidate()
            let sessionData = AppHelper.getSessionData()
            sessionData.restDuration = getWorkDuration()
            
            AppHelper.initSessionData(sessionData: sessionData)
            print("Rest Session")
            print(AppHelper.getSessionData())
            self.song.stop()
            self.performSegue(withIdentifier: "restMoodSegue", sender: nil)
        }
    }
    
    @IBAction func endSessionTapped(_ sender: Any) {
        
        showAlert()
        
        let sessionData = AppHelper.getSessionData()
        sessionData.restDuration = getWorkDuration()
        
        AppHelper.initSessionData(sessionData: sessionData)
        print("Rest Session")
        print(AppHelper.getSessionData())
    }
    
    func getWorkDuration() -> Double {
        return Double(UserDefaultManager.shared.defaults.value(forKey: "restSession") as! Int - restDuration)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: "End rest session?",
            message: "You will end session earlier than the duration you have set up.",
            preferredStyle: .alert
        )
        
        alert.view.tintColor = UIColor(named: "alert")
        
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .default,
            handler: { action in
                self.song.stop()
                self.timer.invalidate()
                self.performSegue(withIdentifier: "restMoodSegue", sender: nil)
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
