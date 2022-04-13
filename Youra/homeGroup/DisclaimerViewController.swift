//
//  DisclaimerViewController.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 09/04/22.
//

import UIKit

class DisclaimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

	@IBAction func proceedClick(_ sender: Any) {
		
	}
}
