//
//  ListViewModel.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

struct ListViewModel {
	
	private var dataSource: GenericDataSource<Rows>?
	public var service: FactServiceProtocol?
	public var onErrorHandling: ((ErrorResult?) -> Void)? // call back for passing event if any failure happen with business logic
	public var messagePassing : ((_ title:String) -> Void)!
	init(service: FactServiceProtocol , dataSource: GenericDataSource<Rows>) {
		self.dataSource = dataSource
		self.service = service
	}
	
	
	///  Method for calling or fetching dropbox data
	internal func fetchList() {
		guard let service = service else {
			onErrorHandling?(ErrorResult.custom(string: "Missing service"))
			return
		}
		// calling api and reloading on main thread
		service.fetchFactsList { result in
			DispatchQueue.main.async {
				switch result {
				case .success(let factsModel) :
					print(factsModel)
					self.messagePassing?(factsModel.title)
					self.dataSource?.data.value = factsModel.rows
				case .failure(let error) :
					self.onErrorHandling?(error)
				}
			}
		}
	}
}
