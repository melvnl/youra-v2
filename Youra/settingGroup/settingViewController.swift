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
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func toggleEveryday(_ sender: Any) {
        print("everydat called")
        everyday = !everyday
                let content = UNMutableNotificationContent()
                content.title = "Weekly Staff Meeting"
                content.body = "Every Tuesday at 2pm"

                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current

                dateComponents.hour = 0
                dateComponents.minute = 20
                // Create the trigger as a repeating event.`
                let trigger = UNCalendarNotificationTrigger(
                         dateMatching: dateComponents, repeats: true)

                // Create the request
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString,
                            content: content, trigger: trigger)
                if(everyday){
                    print("everyday true")

            
                    // Schedule the request with the system.
                    UNUserNotificationCenter.current().add(request) { (error) in
                       if error != nil {
                          // Handle any errors.
                           print("error")
                       }
                    }
            }
                else{
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])
                }
    }
    
    
    @IBAction func toggleOnWeekday(_ sender: Any) {
        print("weekday called")
        weekday = !weekday
                
                let content = UNMutableNotificationContent()
                content.title = "Weekly Staff Meeting"
                content.body = "Every Tuesday at 2pm"
                
                func triggerFor(day: Int) -> DateComponents {
                    var dateComponents = DateComponents()
                    dateComponents.calendar = Calendar.current
                    dateComponents.weekday = day
                    dateComponents.hour = 10
                    dateComponents.minute = 33
                    
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
                       
                            print("weekday true")
                    
                            // Schedule the request with the system.
                            UNUserNotificationCenter.current().add(request) { (error) in
                               if error != nil {
                                  // Handle any errors.
                                   print("error")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = UserDefaultManager.shared.defaults.value(forKey: "username") as? String
        
        print("called")
        
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
