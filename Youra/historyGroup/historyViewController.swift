//
//  historyViewController.swift
//  Youra
//
//  Created by melvin on 09/04/22.
//

import UIKit

class historyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct History {
            let time: String
        }
    
//    let histories = ["tralala","trilili","lele"]

    let histories = [
        History(time: "10.00 - 15.00"),
        History(time: "something"),
    ]


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("history called")
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell", for: indexPath)
//        cell.textLabel?.text = histories[indexPath.row]
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "allCell")
//
        let history = histories[indexPath.row]
        cell.textLabel?.text = history.time

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


