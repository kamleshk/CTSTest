//
//  ListDataSourceTest.swift
//  CTSAssignmentTests
//
//  Created by Kamlesh Kumar on 03/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import XCTest
@testable import CTSAssignment

class ListDataSourceTest: XCTestCase {
	
	var dataSource : ListDataSource!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		dataSource = ListDataSource()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		
		dataSource = nil
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
	
	func testEmptyValueInDataSource() {
		
		// giving empty data value
		dataSource.data.value = []
		
		let tableView = UITableView()
		tableView.dataSource = dataSource
		
		// expected one section
		XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
		
		// expected zero cells
		XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
	}
	
	func testValueInDataSource() {
		
		// giving data value
		let firstRow =   Rows(title: "kamlesh", description: "hi kamelsh supper is going ", imageHref: "https:image url")
		let secondrow = Rows(title: "kamlesh kumar", description: "hi kamelsh supper", imageHref: "https:image url")
		dataSource.data.value = [firstRow, secondrow]
		
		let tableView = UITableView()
		tableView.dataSource = dataSource
		
		// expected one section
		XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
		
		// expected two cells
		XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
	}
	
	func testValueCell() {
		
		// giving data value
		let firstRow =   Rows(title: "kamlesh", description: "hi kamelsh supper is going ", imageHref: "https:image url")
		dataSource.data.value = [firstRow]
		
		let tableView = UITableView()
		tableView.dataSource = dataSource
		tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
		
		let indexPath = IndexPath(row: 0, section: 0)
		
		// expected CurrencyCell class
		guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? ListTableViewCell else {
			XCTAssert(false, "Expected CurrencyCell class")
			return
		}
	}
	
}
