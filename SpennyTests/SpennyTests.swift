//
//  SpennyTests.swift
//  SpennyTests
//
//  Created by Greg Ross on 04/11/2022.
//

import XCTest
import Foundation
import Combine
import CoreData
@testable import Spenny

final class SpennyTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func test_coreDataShouldReturnSpennyEntityWith1243Income(){
        let coreDataManager = CoreDataManager()
        let expectedIncome = 1243.00

        let _ = coreDataManager.spennyDataPublisher
            .sink { returnedResult in
                switch returnedResult{
                case .failure(let error):
                    XCTAssertEqual(error as! CustomError , CustomError.spennyEntityWasNil)
                    
                case .success(let spennyEntity):
                    guard let spennyEntity else { XCTFail("Spenny entity was nil"); return }
                    XCTAssertEqual(spennyEntity.monthlyIncome , expectedIncome)
                }
            }
            .store(in: &cancellables)

        coreDataManager.getSpennyData()
    }
    
    
    func test_dataManagerWithMockCoreData(){
        
    }
    

}
