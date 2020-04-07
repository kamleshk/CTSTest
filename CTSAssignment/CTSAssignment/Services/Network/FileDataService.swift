//
//  FileDataService.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 03/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

/// For testing purpose with local data
final class FileDataService : FactServiceProtocol {
	
	static let shared = FileDataService()
	
	func fetchFactsList(_ completion: @escaping ((Result<Facts, ErrorResult>) -> Void)) {
		
		// giving a sample json file
		guard let data = FileManager.readJson(forResource: "sample") else {
			completion(Result.failure(ErrorResult.custom(string: "No file or data")))
			return
		}
		
		ParserHelper.parse(data: data, completion: completion)
	}
}


extension FileManager {
	
	static func readJson(forResource fileName: String ) -> Data? {
		
		let bundle = Bundle(for: FileDataService.self)
		if let path = bundle.path(forResource: fileName, ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
				return data
			} catch {
				// handle error
			}
		}
		
		return nil
	}
}
