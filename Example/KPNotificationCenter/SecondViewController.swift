//
//  SecondViewController.swift
//  KPNotificationCenter
//
//  Created by kunal08pandey on 07/16/2020.
//  Copyright (c) 2020 kunal08pandey. All rights reserved.
//

import UIKit
import KPNotificationCenter

class SecondViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("Before Observer Retain Count of SecondVC: \(CFGetRetainCount(self))")
		KPNotificationCenter.default.addObserver(self, selector: #selector(notifyMe), name: .notifier, object: nil)
		print("After Observer Retain Count of SecondVC: \(CFGetRetainCount(self))")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("Retain Count of SecondVC: \(CFGetRetainCount(self))")

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("Retain Count of SecondVC: \(CFGetRetainCount(self))")

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func buttonClicked() {
		KPNotificationCenter.default.post(name: .notifier, object: nil)
	}
	
	@objc func notifyMe() {
		print("Called This")
		let alertAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
			self?.view.backgroundColor = .red
		}
		let controller = UIAlertController(title: "Notified", message: "Notifier Called", preferredStyle: .alert)
		controller.addAction(alertAction)
		self.navigationController?.present(controller, animated: false, completion: nil)
	}
	
	deinit {
		KPNotificationCenter.default.removeObserver(self, name: .notifier, object: nil)
	}
	
}

