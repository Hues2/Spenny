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
        dataManager = DataManager(coreDataManager: CoreDataTestManager())
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
        
        waitForExpectations(timeout: 3)
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
    
    // MARK: Savings Goal
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
        
        waitForExpectations(timeout: 3)
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
    
    // MARK: Transactions
    func test_addingTransactionToDataManager_trackViewTransactionsShouldMatch() throws{
        
        let expectedResult = 1
        var result = trackViewModel.transactions.count
        let expectation = self.expectation(description: "Adding Transaction")
                
        // Subscribe to the value that we want to test
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedList in
                result = returnedList.count
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Create a new transaction, using the test core data manager
        let transaction = TransactionEntity(context: dataManager.coreDataManager.container.viewContext)

        // Configure the transaction with the correct values
        transaction.title = "TEST"
        transaction.amount = 10.00
        transaction.date = Date()
        transaction.isDirectDebit = true
        transaction.typeTitle = "car"
        transaction.iconName = "car"
        transaction.hexColor = "ffffff"
        transaction.id = UUID()
        transaction.spennyEntity = dataManager.spennyEntity

        dataManager.addTransaction(transaction: transaction)
        
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(expectedResult, result)
    }
    
    func test_addingMultipleTransactionsToDataManager_trackViewTransactionsCountShouldMatch() throws{
        
        let expectedResult = 3
        var result = 0
        let expectation = self.expectation(description: "Adding Multiple Transactions")
        
        trackViewModel.$transactions // --> Should publish 3 times, as we add 3 transactions to the data manager
            .dropFirst()
            .sink{ returnedTransactions in
                result += 1
                if result == 2{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        
        addTransaction(amount: 25.0)
        addTransaction(amount: 32.0)
        addTransaction(amount: 57.83)
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    // MARK: Transactions Total
    func test_transactionsTotal_shouldBe250() throws {
        let expectedResult: Double = 250
        var counter: Int = 0
        let expectation = self.expectation(description: "Adding Transactions")
        
        
        trackViewModel.$transactions // --> Once this transactions has published 3 times, we will check the value of transactionsTotal
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == 3{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        addTransaction(amount: 100)
        addTransaction(amount: 100)
        addTransaction(amount: 50)
        
        waitForExpectations(timeout: 5)
        
        let value = trackViewModel.transactionsTotal
        

        XCTAssertEqual(value, expectedResult)
        
    }
    
    // MARK: Remaining Amount
    func test_remainingAmount_shouldBe900() throws {
        let expectedResult: Double = 900
        let expectation = self.expectation(description: "Setting Remaining Amount")
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        dataManager.monthlyIncome = 1200
        addTransaction(amount: -300)
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(trackViewModel.remainingAmount, expectedResult)
        
        
        
    }
    
    func test_percentageOfSavingsSoFar_shouldBe90() throws {
        let expectedResult: Double = 90
        let expectation = self.expectation(description: "Calculating Percentage Of Savings Goal")
        var counter = 0
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == 3{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        dataManager.monthlyIncome = 1000
        dataManager.savingsGoal = 100
        
        addTransaction(amount: -900)
        addTransaction(amount: 20)
        addTransaction(amount: -30)
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(expectedResult, trackViewModel.percentageOfSavingsSoFar)
    }
    
    
    
    
    // MARK: Add Transaction
    func addTransaction(amount: Double){
        // Create a new transaction, using the test core data manager
        let transaction = TransactionEntity(context: dataManager.coreDataManager.container.viewContext)

        // Configure the transaction with the correct values
        transaction.title = "TEST"
        transaction.amount = amount
        transaction.date = Date()
        transaction.isDirectDebit = true
        transaction.typeTitle = "car"
        transaction.iconName = "car"
        transaction.hexColor = "ffffff"
        transaction.id = UUID()
        transaction.spennyEntity = dataManager.spennyEntity

        dataManager.addTransaction(transaction: transaction)
    }

}





extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 5,
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
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
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
