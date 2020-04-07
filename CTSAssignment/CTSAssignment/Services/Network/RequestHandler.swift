//
//  RequestHandler.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation


class RequestHandler {
	
	
	/// PRequestHandler this method used for getting model array in result  with error
	/// - Parameter completion: handale parsed data
	/// - Returns: returns json data
	func networkResult<T: Parceable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
		((Result<Data, ErrorResult>) -> Void) {
			
			return { dataResult in
				
				DispatchQueue.global(qos: .background).async(execute: {
					switch dataResult {
					case .success(let data) :
						ParserHelper.parse(data: data, completion: completion)
						break
					case .failure(let error) :
						print("Network error \(error)")
						completion(.failure(.network(string: "Network error " + error.localizedDescription)))
						break
					}
				})
				
			}
	}
	
	/// PRequestHandler this method used for getting model  in result  with error
	/// - Parameter completion: returns parsed data
	/// - Returns: returns json data
	func networkResult<T: Parceable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
		((Result<Data, ErrorResult>) -> Void) {
			
			return { dataResult in
				
				DispatchQueue.global(qos: .background).async(execute: {
					switch dataResult {
					case .success(let data) :
						ParserHelper.parse(data: data, completion: completion)
						break
					case .failure(let error) :
						print("Network error \(error)")
						completion(.failure(.network(string: "Network error " + error.localizedDescription)))
						break
					}
				})
				
			}
	}
}
