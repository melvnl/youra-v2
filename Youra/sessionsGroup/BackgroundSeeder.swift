//
//  BackgroundSeeder.swift
//  Youra
//
//  Created by Stephen Giovanni Saputra on 10/04/22.
//

import Foundation
import UIKit

class BackgroundSeeder {
    
    func generateData() -> [Background] {
        
        return [
        
            Background(
                bgTitle: UIImage(named: "background0.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.15),
                foregroundLayerColor: UIColor(red: 209/255, green: 201/255, blue: 226/255, alpha: 1),
                timerLabelColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.6),
                noteButtonBGColor: UIColor(red: 167/255, green: 164/255, blue: 172/255, alpha: 1),
                noteIconColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                pauseButtonColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                ),
            
            Background(
                bgTitle: UIImage(named: "background1.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3),
                foregroundLayerColor: UIColor(red: 65/255, green: 58/255, blue: 92/255, alpha: 1),
                timerLabelColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.8),
                noteButtonBGColor: UIColor(red: 167/255, green: 164/255, blue: 172/255, alpha: 1),
                noteIconColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                pauseButtonColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                ),
            
            Background(
                bgTitle: UIImage(named: "background2.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3),
                foregroundLayerColor: UIColor(red: 65/255, green: 58/255, blue: 92/255, alpha: 1),
                timerLabelColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.8),
                noteButtonBGColor: UIColor(red: 167/255, green: 164/255, blue: 172/255, alpha: 1),
                noteIconColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                pauseButtonColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                ),
            
            Background(
                bgTitle: UIImage(named: "background3.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3),
                foregroundLayerColor: UIColor(red: 65/255, green: 58/255, blue: 92/255, alpha: 1),
                timerLabelColor: UIColor(red: 85/255, green: 76/255, blue: 107/255, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.8),
                noteButtonBGColor: UIColor(red: 217/255, green: 209/255, blue: 236/255, alpha: 1),
                noteIconColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                pauseButtonColor: UIColor(red: 85/255, green: 76/255, blue: 107/255, alpha: 1)
                ),
            
            Background(
                bgTitle: UIImage(named: "background4.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3),
                foregroundLayerColor: UIColor(red: 65/255, green: 58/255, blue: 92/255, alpha: 1),
                timerLabelColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.8),
                noteButtonBGColor: UIColor(red: 217/255, green: 209/255, blue: 236/255, alpha: 1),
                noteIconColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                pauseButtonColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                ),
            
            Background(
                bgTitle: UIImage(named: "background5.png"),
                backgroundLayerColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3),
                foregroundLayerColor: UIColor(red: 65/255, green: 58/255, blue: 92/255, alpha: 1),
                timerLabelColor: UIColor(red: 85/255, green: 76/255, blue: 107/255, alpha: 1),
                circularViewColor: UIColor(red: 42/255, green: 33/255, blue: 78/255, alpha: 0.8),
                noteButtonBGColor: UIColor(red: 217/255, green: 209/255, blue: 236/255, alpha: 1),
                noteIconColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                pauseButtonColor: UIColor(red: 85/255, green: 76/255, blue: 107/255, alpha: 1)
                ),
        ]
    }
    
    func generateQuotes() -> [Quote] {
        
        return [
            Quote(quote: "“Don’t be busy, be productive“"),
            Quote(quote: "“Be kind to yourself today“"),
            Quote(quote: "“It's okay to\n take a break“"),
            Quote(quote: "“If you're tired learn to rest,\n not quit“"),
            Quote(quote: "“Everything is\n hard before\n it's easy“"),
            Quote(quote: "“Work on you, for you“")
        ]
    }
}
