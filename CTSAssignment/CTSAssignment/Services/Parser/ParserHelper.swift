//
//  ParserHelper.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation


/// Protocol for parsing json data into conforming protocol class
protocol Parceable {
	static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

/// Praser helper call supports in parsing the data which we had got from api request . This class converts Data into keyvalue paired aor JSON format  where its going to pass these json data to desired model
final class ParserHelper {
	
	/// Method for parsing api Data which is apected to be in array or model
	/// - Parameters:
	///   - data: api response data
	///   - completion: completion  aprsed result Model
	static func parse<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
		
		do {
			
			if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
				
				// init final result
				var finalResult : [T] = []
				
				
				for object in result {
					if let dictionary = object as? [String : AnyObject] {
						
						// check foreach dictionary if parseable
						switch T.parseObject(dictionary: dictionary) {
						case .failure(_):
							continue
						case .success(let newModel):
							finalResult.append(newModel);
							break
						}
					}
				}
				
				completion(.success(finalResult))
				
			} else {
				// not an array
				completion(.failure(.parser(string: "Json data is not an array")))
			}
		} catch {
			// can't parse json
			completion(.failure(.parser(string: "Error while parsing json data")))
		}
	}
	
	
	/// Method for  json serilization  which is be keyvalue pair
	/// - Parameters:
	///   - data: api request data
	///   - completion: result as model or error
	static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
		
		do {
			let dataStr = String(decoding: data, as: UTF8.self)
			let dataL  = dataStr.data(using: .utf8)!
			if let dictionary = try JSONSerialization.jsonObject(with: dataL , options: [] ) as? [String: AnyObject] {
				
				switch T.parseObject(dictionary: dictionary) {
				case .failure(let error):
					completion(.failure(error))
					break
				case .success(let newModel):
					completion(.success(newModel))
					break
				}
			} else {
				// not an array
				completion(.failure(.parser(string: "Json data is not an array")))
			}
		} catch  {
			// can't parse json
			completion(.failure(.parser(string: "Error while parsing json data")))
		}
	}
}
