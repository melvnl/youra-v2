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

        // Do any additional setup after loading the view.
		print("Notes")
		notesTitle.text = sessionData.noteTitle
		notesBody.text = sessionData.noteBody

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
