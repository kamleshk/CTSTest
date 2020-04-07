//
//  ListModelViewTest.swift
//  CTSAssignmentTests
//
//  Created by Kamlesh Kumar on 03/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import XCTest
@testable import CTSAssignment
class ListModelViewTest: XCTestCase {

    var viewModel : ListViewModel!
    var dataSource : GenericDataSource<Rows>!
    fileprivate var service : MockCurrencyService!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.service = MockCurrencyService()
        self.dataSource = GenericDataSource<Rows>()
        self.viewModel = ListViewModel(service: service , dataSource: dataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service List")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch Facts
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchCurrencies() {
        
        let expectation = XCTestExpectation(description: "Facts fetched")
        
        // giving a service mocking currencies
        service.facts = Facts(title: "Testing kam", rows: [])
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoCurrencies() {
        
        let expectation = XCTestExpectation(description: "No Facts")
        
        // giving a service mocking error during fetching currencies
        service.facts = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }

}


fileprivate class MockCurrencyService : FactServiceProtocol {
    
    
    var facts : Facts?
    
    func fetchFactsList(_ completion: @escaping ((Result<Facts, ErrorResult>) -> Void)) {
        
        if let fact = facts {
            completion(Result.success(fact))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}
