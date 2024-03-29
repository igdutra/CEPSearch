//
//  CEPDetailsUIIntegrationTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
// Test behavior of the module through its public interface
import CEPiOS
import CEPSearch
@testable import CEPApp

final class CEPDetailsUIIntegrationTests: XCTestCase {
    
    func test_viewInitialization_rendersProvidedData() {
        let details = CEPDetails(cep: "12345-678",
                                 street: "Example Street",
                                 complement: "Apt 101",
                                 district: "Example District",
                                 city: "Example City",
                                 state: "EX")
        
        let viewData = CEPDetailsViewModel.map(details)
        
        let sut = makeSUT(details: details)
        
        // Force view lifecycle
        // By manually running the run loop, you give the system a chance to process pending operations that might be running in the main thread
        sut.simulateAppearance()
        
        XCTAssertEqual(sut.cepText(), viewData.cepText)
        XCTAssertEqual(sut.addressText(), viewData.addressTexts.info)
        XCTAssertEqual(sut.districtText(), viewData.districtTexts.info)
        XCTAssertEqual(sut.cityStateText(), viewData.cityStateTexts.info)
    }
}

// MARK: - Helpers

private extension CEPDetailsUIIntegrationTests {
    func makeSUT(details: CEPDetails, file: StaticString = #filePath, line: UInt = #line) -> CEPDetailsViewController {
        let viewController = CEPDetailsUIComposer.detailsComposed(with: details)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return viewController
    }
}

