//
//  historyViewController.swift
//  Youra
//
//  Created by melvin on 09/04/22.
//

import UIKit

class historyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let context = (UIApplication.self.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
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
		AppHelper.initTempDetailData(sessionData: items[indexPath.row])
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
