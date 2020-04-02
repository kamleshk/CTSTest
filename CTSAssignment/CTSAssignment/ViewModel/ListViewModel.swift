//
//  ListViewModel.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

struct ListViewModel {
    
     var dataSource : GenericDataSource<Rows>?
     var service: FactServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: FactServiceProtocol /*= CurrencyService.shared*/, dataSource : GenericDataSource<Rows>) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchCurrencies() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchFactsList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let factsModel) :
                    print(factsModel)
                    self.dataSource?.data.value = factsModel.rows
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
