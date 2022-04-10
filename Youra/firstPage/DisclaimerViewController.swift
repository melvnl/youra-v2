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

        // Do any additional setup after loading the view.
    }


	@IBAction func proceedClick(_ sender: Any) {
		let storyboard = UIStoryboard(name: "homeScreen", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
