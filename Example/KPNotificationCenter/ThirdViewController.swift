//
//  ThirdViewController.swift
//  KPNotificationCenter
//
//  Created by kunal08pandey on 07/16/2020.
//  Copyright (c) 2020 kunal08pandey. All rights reserved.
//

import UIKit
import KPNotificationCenter

class ThirdViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func buttonClicked() {
		KPNotificationCenter.default.post(name: .notifier, object: nil)
	}
}

