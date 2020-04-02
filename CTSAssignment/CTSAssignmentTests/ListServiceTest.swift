//
//  ListServiceTest.swift
//  CTSAssignmentTests
//
//  Created by Kamlesh Kumar on 03/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import XCTest
@testable import CTSAssignment

class ListServiceTest: XCTestCase {
    
    func testCancelRequest() {
        
        // giving a "previous" session
        FactListService.shared.fetchFactsList { (_) in
            // ignore call
        }
        
        // Expected to task nil after cancel
        FactListService.shared.cancelFetchCurrencies()
        XCTAssertNil(FactListService.shared.task, "Expected task nil")
    }
}
