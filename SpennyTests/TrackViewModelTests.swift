//
//  TrackViewModelTests.swift
//  SpennyTests
//
//  Created by Greg Ross on 16/11/2022.
//

import XCTest
import Foundation
import Combine
import CoreData
@testable import Spenny

final class TrackViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var dataManager: DataManager!
    var trackViewModel: TrackViewModel!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager = DataManager(coreDataManager: CoreDataManager())
        trackViewModel = TrackViewModel(dataManager: dataManager)
    }

    //MARK: - Monthly Income
    func test_changingMontlyIncomeFromDataManager_trackViewMonthlyIncomeShouldChange() throws{
        
        let expectedResult: Double = 1000
        var result: Double?
        let expectation = self.expectation(description: "Changing Monthly Income")
       
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
    
    func test_changingMontlyIncomeFromDataManagerToNil_trackViewMonthlyIncomeShouldNotChange() throws{
        
        let expectedResult = trackViewModel.monthlyIncome // --> The trackViewModel.monthlyIncome should not change
       
        trackViewModel.$monthlyIncome
            .dropFirst()
            .sink { returnedDouble in // --> This shouldn't run when dataManager.monthlyIncome is nil
                XCTFail("When the data managers monthly income is nil, this .sink should not run")
            }
            .store(in: &cancellables)

        
        dataManager.monthlyIncome = nil
        
        XCTAssertEqual(trackViewModel.monthlyIncome, expectedResult)
         
    }
    
    func test_changingSavingsGoalFromDataManager_trackViewSavingsGoalShouldChange() throws{
        let expectedResult: Double = 68.22
        var result: Double?
        
        let expectation = self.expectation(description: "Changing Savings Goal")
        
        trackViewModel.$savingsGoal
            .dropFirst()
            .sink{ returnedDouble in
                result = returnedDouble
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        dataManager.savingsGoal = expectedResult
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, expectedResult)
        
    }
    
    func test_changingSavingsGoalFromDataManagerToNil_trackViewSavingsGoalShouldNotChange() throws{
        let expectedResult: Double = trackViewModel.savingsGoal // --> The trackViewModel.savingsGoal should not change
                
        trackViewModel.$savingsGoal
            .dropFirst()
            .sink{ returnedDouble in
                XCTFail("When the data managers savings goal is nil, this .sink should not run")
            }
            .store(in: &cancellables)
        
        dataManager.savingsGoal = nil
        
        XCTAssertEqual(trackViewModel.savingsGoal, expectedResult)
        
    }
    
    func test_addingTransactionToDataManager_trackViewTransactionsShouldMatch() throws{
        let testDataManager = CoreDataTestManager()
//        let trackViewModel = TrackViewModel(dataManager: testDataManager)
        
        
        
    }

}
