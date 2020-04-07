//
//  DynamicValue.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

/// Reactive programming
/// Going to notify to all who had registerd on it
class DynamicValue<T> {
	
	typealias CompletionHandler = ((T) -> Void)
	
	var value : T {
		didSet {
			self.notify()
		}
	}
	
	private var observers = [String: CompletionHandler]()
	
	init(_ value: T) {
		self.value = value
	}
	
	/// Adding lobservers who is going to observed
	/// - Parameters:
	///   - observer: any class which is derived from nsobject class (any value which is observing it)
	///   - completionHandler: closers function
	public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
		observers[observer.description] = completionHandler
	}
	
	/// Listiners
	/// - Parameters:
	///   - observer: any class which is derived from nsobject class (any value which is observing it)
	///   - completionHandler: closers function
	public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
		self.addObserver(observer, completionHandler: completionHandler)
		self.notify()
	}
	
	private func notify() {
		observers.forEach({ $0.value(value) })
	}
	
	/// Releasing all events
	deinit {
		observers.removeAll()
	}
}
