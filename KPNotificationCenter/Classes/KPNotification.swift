//
//  KPNotification.swift
//  KPNotificationCenter
//
//  Created by Kunal Pandey on 16/07/20.
//

import UIKit

public struct KPNotification {

	public typealias Name = String
	
	public typealias Observer = AnyObject
	
	public var name: KPNotification.Name?
	
	var object: Any?
	
	var userInfo: [AnyHashable: Any] = [:]
	
	weak var observer: Observer?
	
	var selector: Selector?
	
	var queue: OperationQueue?
	
	var block: NotificationCallback?
	
	init(name: KPNotification.Name,
			 observer: Observer,
			 object: Any?,
			 selector: Selector) {
		self.object = object
		self.name = name
		self.selector = selector
		self.observer = observer
	}
	
	init(name: KPNotification.Name,
			 object: Any?,
			 queue: OperationQueue,
			 block: @escaping NotificationCallback) {
		self.name = name
		self.object = object
		self.queue = queue
		self.block = block
	}
	
	mutating func update(userInfo: [AnyHashable: Any]) {
		self.userInfo.removeAll()
		for userInfoItem in userInfo {
			self.userInfo[userInfoItem.key] = userInfoItem.value
		}
	}
	
}
