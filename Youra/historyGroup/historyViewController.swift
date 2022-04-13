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

	let context = (UIApplication.self.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let histories = [
        History(time: "4 Oct 22 , 10.00 - 15.00"),
        History(time: "5 Oct 22 , 11.00 - 14.00"),
    ]

	var items:[SessionData] = []


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

		fetchHistory()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! historyTableViewCell
        
        let selectedBg = UIView()
        selectedBg.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBg
        
        let history = items[indexPath.row]
		cell.myLabel.text = AppHelper.getStringDateTime(startDate: history.createDate!, endDate:  history.endDate!)
        
        return cell
    }
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "detailSegue", sender: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
    
	func fetchHistory() {
		do {
			self.items = try context.fetch(SessionData.fetchRequest())
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		} catch {
			print("Gagal mendapatkan data")
		}


	}
}
