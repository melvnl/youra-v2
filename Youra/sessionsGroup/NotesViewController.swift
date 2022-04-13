//
//  NotesViewController.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 13/04/22.
//

import UIKit

class NotesViewController: UIViewController {

	@IBOutlet weak var notesTitle: UITextField!
	@IBOutlet weak var notesBody: UITextField!
	var sessionData = AppHelper.getSessionData()


	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "info",
																 style: .plain,
																 target: self,
																 action: #selector(showInfo))

        // Do any additional setup after loading the view.
		print("Notes")
		notesTitle.text = sessionData.noteTitle
		notesBody.text = sessionData.noteBody

    }

	@objc
	func showInfo() {
		let alert = UIAlertController(
			title: "You’re free to write anything!",
			message: "You’re feelings \n Lyric you compose \n What happened today \n Poems A story \n And many more!",
			preferredStyle: .alert
		)

		alert.addAction(UIAlertAction(
			title: "Close",
			style: .destructive,
			handler: { action in
			})
		)

		present(alert, animated: true)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			setNotes()
		}
	}

	func setNotes() {
		sessionData.noteTitle = notesTitle.text
		sessionData.noteBody = notesBody.text

		AppHelper.initSessionData(sessionData: sessionData)
		print("Rest Session")
		print(AppHelper.getSessionData())
	}


}
