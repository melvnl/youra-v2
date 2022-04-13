//
//  AppHelper.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 12/04/22.
//

import Foundation
import UIKit

class AppHelper {
	static var sessionData:SessionData!
	static var tempDetailData:SessionData!

	static func initTempDetailData(sessionData:SessionData) {
		self.tempDetailData = sessionData
	}

	static func destroyTempDetailData() {
		self.tempDetailData = nil
	}

	static func initSessionData(sessionData:SessionData) {
		self.sessionData = sessionData
	}

	static func getSessionData() -> SessionData {
		return sessionData
	}

	static func getStringTime(date:Date) -> String {
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: date)
		let minutes = calendar.component(.minute, from: date)

		let time = "\(hour).\(minutes)"

		return time
	}

	static func getStringDate(date:Date) -> String {
		let calendar = Calendar.current
		let year = calendar.component(.year, from: date)

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "LLLL"
		let month = dateFormatter.string(from: date)

		let day = calendar.component(.day, from: date)

		let time = "\(day) \(month) \(year)"

		return time
	}

	static func getStringDateTime(startDate:Date, endDate:Date) -> String {
		let startTime = self.getStringTime(date: startDate)
		let endTime   = self.getStringTime(date: endDate)
		let date 	  = self.getStringDate(date: startDate)

		return "\(date), \(startTime) - \(endTime)"
	}

	static func setMoodImage(mood:Float) -> UIImage {
		var moodImage: UIImage!

		if (mood >= 0.75) {
			moodImage = UIImage(named:"emoji 4.png")
		}
		else if (mood >= 0.5){
			moodImage = UIImage(named:"emoji 3.png")
		}
		else if (mood >= 0.25){
			moodImage = UIImage(named:"emoji 2.png")
		}
		else {
			moodImage = UIImage(named:"emoji 1.png")
		}

		return moodImage
	}

}
