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



	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		print("Notes")
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			setNotes()
		}
	}

	func setNotes() {
		let sessionData = AppHelper.getSessionData()
		sessionData.noteTitle = notesTitle.text
		sessionData.noteBody = notesBody.text

		AppHelper.initSessionData(sessionData: sessionData)
		print("Rest Session")
		print(AppHelper.getSessionData())
	}


}
