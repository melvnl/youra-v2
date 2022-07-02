//
//  NotesViewController.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 13/04/22.
//

import UIKit

class NotesViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {


	@IBOutlet weak var notesTitle: UITextField!
	@IBOutlet weak var notesBody: UITextView!
	var sessionData = AppHelper.getSessionData()


	override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTitle.delegate = self
        notesTitle.tag = 0 //Increment accordingly
        
        configureTextFieldObservers()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showInfo))

        // Do any additional setup after loading the view.
		print("Notes")
		notesTitle.text = sessionData.noteTitle
		notesBody.text = sessionData.noteBody

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          // Try to find next responder
        if textField == notesTitle {
               textField.resignFirstResponder()
               notesBody.becomeFirstResponder()
            } else {
             // Not found, so remove keyboard.
             textField.resignFirstResponder()
          }
          // Do not add a line break
          return false
       }

	@objc
	func showInfo() {
		let alert = UIAlertController(
			title: "You’re free to write anything!",
			message: "You’re feelings \n Lyric you compose \n What happened today \n Poems\n A story \n And many more!",
			preferredStyle: .alert
		)

        alert.view.tintColor = UIColor { tc in
                    switch tc.userInterfaceStyle {
                    case .dark:
                        return UIColor(red: 153/255, green: 132/255, blue: 243/255, alpha: 1)
                    default:
                        return UIColor(red: 50/255, green: 32/255, blue: 117/255, alpha: 1)
                    }
                }
		alert.addAction(UIAlertAction(
			title: "Close",
			style: .cancel,
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

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        notesTitle.resignFirstResponder()
        notesBody.resignFirstResponder()
    }
    
    func configureTextFieldObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
}
