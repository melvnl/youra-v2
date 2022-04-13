//
//  detailViewController.swift
//  Youra
//
//  Created by melvin on 13/04/22.
//

import UIKit

class detailViewController: UIViewController {


	@IBOutlet weak var startTime: UILabel!
	@IBOutlet weak var moodBefore: UIImageView!
	@IBOutlet weak var endTime: UILabel!
	@IBOutlet weak var moodAfter: UIImageView!
	@IBOutlet weak var noteTitle: UILabel!
	@IBOutlet weak var noteBody: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()

		let detail = AppHelper.tempDetailData
		noteTitle.text = detail?.noteTitle
		noteBody.text  = detail?.noteBody
		startTime.text = AppHelper.getStringTime(date: (detail?.createDate)!)
		endTime.text = AppHelper.getStringTime(date: (detail?.endDate)!)
		moodBefore.image = AppHelper.setMoodImage(mood: detail!.moodBefore)
		moodAfter.image = AppHelper.setMoodImage(mood: detail!.moodAfter)
		
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			AppHelper.destroyTempDetailData()
		}
	}



}
