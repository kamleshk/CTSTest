//
//  FactListService.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

/// Protocol for fetching api data from given API
protocol FactServiceProtocol : class {
	func fetchFactsList(_ completion: @escaping ((Result<Facts, ErrorResult>) -> Void))
}

/// Class for fetching  all data from dropbox api
final class FactListService : RequestHandler {
	
	static let shared = FactListService()
	// letter i will make as base url and componenet of url for now i am keeping single url
	let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
	var task : URLSessionTask?
	
	/// Cancelling api request which is running
	func cancelFetchCurrencies() {
		if let task = task {
			task.cancel()
		}
		task = nil
	}
}

/// Extension for FactListService conforming "FactServiceProtocol" protocol
extension FactListService : FactServiceProtocol {
	
	func fetchFactsList(_ completion: @escaping ((Result<Facts, ErrorResult>) -> Void)) {
		self.cancelFetchCurrencies()
		task = RequestService().loadData(urlString: endpoint, completion:
			self.networkResult(completion: completion)
		)
	}
}
