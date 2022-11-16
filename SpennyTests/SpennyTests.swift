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
    var dataManager: DataManager!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager = DataManager()
    }


    func test_changingMontlyIncomeFromDataManager_trackViewMonthlyIncomeShouldChange() throws{
        
        let trackViewModel = TrackViewModel(dataManager: dataManager)
        
        let expectedResult: Double = 1000

        var result: Double?
        
        let expectation = self.expectation(description: "Scaling")
       
        trackViewModel.$monthlyIncome
            .dropFirst() // --> Drop the initial value, which is 0.0
            .sink { returnedDouble in
                result = returnedDouble
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        dataManager.monthlyIncome = expectedResult
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, expectedResult)
         
    }
    
    
    
    

}


extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("\n 1 \n")
                    result = .failure(error)
                case .finished:
                    print("\n 2 \n")
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                print("\n 3 \n")
                result = .success(value)
            }
        )
                

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
