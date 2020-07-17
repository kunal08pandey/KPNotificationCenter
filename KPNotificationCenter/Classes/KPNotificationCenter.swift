//
//  KPNotification.swift
//  KPNotificationCenter
//
//  Created by Kunal Pandey on 16/07/20.
//

import Foundation

public typealias NotificationCallback = (KPNotification) -> Void

open class KPNotificationCenter: NSObject {
	
	public static let `default` = KPNotificationCenter()
	
	private var hashMap: [KPNotification.Name: [KPNotification]] = [:]
	
	/// Add observer to notification center with notification name & register a block.
	/// - Parameters:
	///   - forName: name of the notification
	///   - object: object description
	///   - queue: queue description
	///   - using: block or piece of code
	public func addObserver(forName name: KPNotification.Name,
													object: Any?, queue: OperationQueue?, using block: @escaping NotificationCallback) {
		
		let notification = KPNotification(name: name, object: object, queue: queue ?? .main, block: block)
		addNotification(name: name, notification: notification)
	}
	
	public func addObserver(_ observer: Any,
													selector: Selector, name: KPNotification.Name, object: Any?) {
		let notification = KPNotification(name: name, observer: observer as AnyObject, object: object, selector: selector)
		addNotification(name: name, notification: notification)
	}
	
	private func addNotification(name: KPNotification.Name, notification: KPNotification) {
		var notificationList = [KPNotification]()
		if let notifications = hashMap[name] {
			notificationList.append(contentsOf: notifications)
			hashMap[name]?.removeAll()
		}
		notificationList.append(notification)
		hashMap[name] = notificationList
	}
	
	public func post(notification: KPNotification) {
		if let name = notification.name {
			post(name: name, object: notification.object, userInfo: notification.userInfo)
		}
	}
	
	public func post(name: KPNotification.Name, object: Any?) {
		post(name: name, object: object, userInfo: [:])
	}
	
	public func post(name: KPNotification.Name, object: Any?, userInfo: [AnyHashable: Any]) {
		if let notificationList = hashMap[name], notificationList.count > 0 {
			notificationList.forEach {
				performNotification(notification: $0, userInfo: userInfo)
			}
		}
	}
	
	private func performNotification(notification: KPNotification, userInfo: [AnyHashable: Any]) {
		if notification.block != nil {
			performOverBlock(notification: notification, userInfo: userInfo)
		} else {
			performOverSelector(notification: notification, userInfo: userInfo)
		}
	}
	
	private func performOverBlock(notification: KPNotification, userInfo: [AnyHashable: Any]) {
		if let block = notification.block {
			let operationQueue = notification.queue ?? .main
			operationQueue.addOperation {
				var notificationObj = notification
				notificationObj.update(userInfo: userInfo)
				block(notificationObj)
			}
		}
	}
	
	private func performOverSelector(notification: KPNotification, userInfo: [AnyHashable: Any]) {
		if let observer = notification.observer, let selector = notification.selector {
			_ = (observer as AnyObject).perform(selector)
		}
	}
	
	public func removeObserver(_ observer: Any) {
		var filterNotificationList = hashMap.values.flatMap { $0 }
		filterNotificationList.removeAll(where: { (notification) -> Bool in
			if let observerValue1 = notification.observer, (observer as AnyObject).isEqual(observerValue1) {
				return true
			}
			return false
		})
	}
	
	public func removeObserver(_ observer: Any, name aName: KPNotification.Name, object anObject: Any?) {
		var filterNotificationList = hashMap[aName]
		filterNotificationList?.removeAll(where: { (notification) -> Bool in
			if let observerValue1 = notification.observer, (observer as AnyObject).isEqual(observerValue1) {
				return true
			}
			return false
		})
		
	}
	
	private func remove() {

	}
	
}
