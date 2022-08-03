//
//  settingViewController.swift
//  Youra
//
//  Created by melvin on 09/04/22.
//

import UIKit
import UserNotifications

class settingViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var everyday = false
    var weekday = false
    
    @IBOutlet weak var lightBtn: UIButton!
    @IBOutlet weak var darkBtn: UIButton!
    
    @IBAction func toggleEveryday(_ sender: Any) {
        everyday = !everyday
                let content = UNMutableNotificationContent()
                content.title = "You are working today right?"
                content.body = "We care about your stress! Don't push yourself too hard! - Love, YOURA"

                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current

                dateComponents.hour = 10
                // Create the trigger as a repeating event.`
                let trigger = UNCalendarNotificationTrigger(
                         dateMatching: dateComponents, repeats: true)

                // Create the request
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString,
                            content: content, trigger: trigger)
                if(everyday){
            
                    // Schedule the request with the system.
                    UNUserNotificationCenter.current().add(request) { (error) in
                       if error != nil {
                          // Handle any errors.
                       }
                    }
            }
                else{
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])
                }
    }
    
    
    @IBAction func toggleOnWeekday(_ sender: Any) {
        weekday = !weekday
                
                let content = UNMutableNotificationContent()
                content.title = "Don't forget to take a break!"
                content.body = "You have done a really great job! Take a rest now - Love, YOURA"
                
                func triggerFor(day: Int) -> DateComponents {
                    var dateComponents = DateComponents()
                    dateComponents.calendar = Calendar.current
                    dateComponents.weekday = day
                    dateComponents.hour = 10
                    
                    return dateComponents
                   }

                // Create the trigger as a repeating event for weekday only (monday represent with number 2)
                let triggers = [
                    UNCalendarNotificationTrigger(dateMatching: triggerFor(day: 2), repeats: true),
                    UNCalendarNotificationTrigger(dateMatching: triggerFor(day: 3), repeats: true),
                    UNCalendarNotificationTrigger(dateMatching: triggerFor(day: 4), repeats: true),
                    UNCalendarNotificationTrigger(dateMatching: triggerFor(day: 5), repeats: true),
                    UNCalendarNotificationTrigger(dateMatching: triggerFor(day: 6), repeats: true)
                ]
                
                let uuidString = UUID().uuidString

                // Create the request
                if(weekday){
                    for trigger in triggers {
                        
                        let request = UNNotificationRequest(identifier: uuidString,
                                    content: content, trigger: trigger)
                    
                            // Schedule the request with the system.
                            UNUserNotificationCenter.current().add(request) { (error) in
                               if error != nil {
                                  // Handle any errors.
                               }
                            }
                    }
                }
                else{
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])
                }
    }
    
    @IBAction func lightModePressed(_ sender: Any) {
        colorUserDefaults.colorshared.theme = .light
        self.view.window?.overrideUserInterfaceStyle = colorUserDefaults.colorshared.theme.getUserInterfaceStyle()
    }
    
    
    @IBAction func darkModePressed(_ sender: Any) {
        colorUserDefaults.colorshared.theme = .dark
        self.view.window?.overrideUserInterfaceStyle = colorUserDefaults.colorshared.theme.getUserInterfaceStyle()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
               if (self.traitCollection.userInterfaceStyle == .dark){
                   darkBtn.layer.borderColor = UIColor(red: 174/255, green: 143/255, blue: 177/255, alpha: 1).cgColor
                   lightBtn.layer.borderColor = UIColor(red: 174/255, green: 143/255, blue: 177/255, alpha: 0).cgColor
               }
               else{
                   darkBtn.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor
                   lightBtn.layer.borderColor = UIColor(red: 174/255, green: 143/255, blue: 177/255, alpha: 1).cgColor
               }
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        darkBtn.layer.borderWidth = 2
        darkBtn.layer.cornerRadius = 10
        darkBtn.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor(red: 174/255, green: 143/255, blue: 177/255, alpha: 1).cgColor : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor
        
        lightBtn.layer.borderWidth = 2
        lightBtn.layer.cornerRadius = 10
        lightBtn.layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor(red: 174/255, green: 143/255, blue: 177/255, alpha: 1).cgColor  : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor
        
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                // Handle the error here.
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }


}
