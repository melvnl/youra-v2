//
//  AppHelper.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 12/04/22.
//

import Foundation

class AppHelper {
	static var sessionData:SessionData!

	static func initSessionData(sessionData:SessionData) {
		self.sessionData = sessionData
	}

	static func getSessionData() -> SessionData {
		return sessionData
	}


}
