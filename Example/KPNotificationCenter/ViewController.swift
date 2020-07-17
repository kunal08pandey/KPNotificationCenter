//
//  ViewController.swift
//  KPNotificationCenter
//
//  Created by kunal08pandey on 07/16/2020.
//  Copyright (c) 2020 kunal08pandey. All rights reserved.
//

import UIKit
import KPNotificationCenter

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		KPNotificationCenter.default.addObserver(forName: .notifier, object: nil, queue: .main) { [weak self] (_) in
			self?.title = "Title Changed"
			
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

