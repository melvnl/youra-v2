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

    let histories = [
        History(time: "4 Oct 22 , 10.00 - 15.00"),
        History(time: "5 Oct 22 , 11.00 - 14.00"),
    ]


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("history called")
        
        let nib = UINib(nibName: "historyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "historyTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! historyTableViewCell
        
        let selectedBg = UIView()
        selectedBg.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBg
        
        let history = histories[indexPath.row]
        cell.myLabel.text = history.time

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


