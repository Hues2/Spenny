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
    let timeout: Double = 4


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager = DataManager(coreDataManager: CoreDataTestManager())
        dataManager.spennyEntity = SpennyEntity(context: dataManager.coreDataManager.container.viewContext) // --> So that the core data "add" and "delete" functionality works 
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
        
        waitForExpectations(timeout: timeout)
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
        
        waitForExpectations(timeout: timeout)
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
        
        waitForExpectations(timeout: timeout)
        
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
        
        waitForExpectations(timeout: timeout)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_transactions_addRandomNumberOfTransactionsWithRandomValuesAsNewUser() throws{
        let randomNumberOfTransactions = Int.random(in: 1...10)
        let expectedResult = randomNumberOfTransactions
        let expectation = self.expectation(description: "Adding random number of transactions")
        var counter = 0
        dataManager.isNewUser = true    // --> This means that the transactions don't get saved to core data,
                                        //but will still make the transactions in the data manager publish a value
        
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == randomNumberOfTransactions{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        for _ in 0..<randomNumberOfTransactions{
            addTransaction(amount: Double.random(in: -150...150))
        }
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.transactions.count)
        
    }

    func test_transactions_addRandomNumberOfTransactionsWithRandomValuesNotAsNewUser() throws{
        let randomNumberOfTransactions = Int.random(in: 1...10)
        let expectedResult = randomNumberOfTransactions
        let expectation = self.expectation(description: "Adding random number of transactions")
        var counter = 0
        dataManager.isNewUser = false   // --> This means that the transactions get saved to core data,
                                        // which wil also publish a value when it loaded the data back (after saving)
        
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == randomNumberOfTransactions{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        for _ in 0..<randomNumberOfTransactions{
            addTransaction(amount: Double.random(in: -150...150))
        }
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.transactions.count)
        
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
        
        waitForExpectations(timeout: timeout)
        
        let value = trackViewModel.transactionsTotal
        
        XCTAssertEqual(value, expectedResult)
    }
    
    func test_transactionsTotal_shouldBeNegative500() throws {
        let expectedResult: Double = -500
        var counter: Int = 0
        let expectation = self.expectation(description: "Adding Transactions")
        
        
        trackViewModel.$transactions // --> Once this transactions has published 3 times, we will check the value of transactionsTotal
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == 4{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        addTransaction(amount: 100)
        addTransaction(amount: -500)
        addTransaction(amount: 50)
        addTransaction(amount: -150)
        
        waitForExpectations(timeout: timeout)
        
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
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(trackViewModel.remainingAmount, expectedResult)
  
    }
    
    // MARK: Percntage Of Savings So Far
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
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.percentageOfSavingsSoFar)
    }
    
    func test_percentageOfSavingsSoFar_shouldBe110() throws {
        let expectedResult: Double = 110
        let expectation = self.expectation(description: "Calculating Percentage Of Savings Goal")
        var counter = 0
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == 4{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        dataManager.monthlyIncome = 1000
        dataManager.savingsGoal = 100
        
        addTransaction(amount: -900)
        addTransaction(amount: -30)
        addTransaction(amount: 60)
        addTransaction(amount:-20)
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.percentageOfSavingsSoFar)
    }
    
    // MARK: Info Box Center Percent
    func test_infoBoxCenterPercent_shouldBeHalf() throws {
        let expectedResult = 0.5
        let expectation = self.expectation(description: "Calculating Percentage")
        var counter = 0
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransactions in
                counter += 1
                if counter == 2{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        dataManager.monthlyIncome = 1000
        addTransaction(amount: 25)
        addTransaction(amount: -525)
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.infoBoxCenterPercent)
        
    }
    
    // MARK: Delete Transaction
    func test_deleteTransaction_numberOfTransactionsShouldBe0() throws{
        let expectedResult = 0
        let expectation = self.expectation(description: "Deleting transaction")
        var counter = 0
        
        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransaction in
                counter += 1
                if counter == 2{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        addTransaction(amount: 50) // --> This will make the first publish
        trackViewModel.deleteTransaction(index: IndexSet(integer: 0))
        
        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.transactions.count)
        
    }
    
    func test_deleteTransaction_numberOfTransactionsShouldBe2() throws{
        let expectedResult = 2
        let expectation = self.expectation(description: "Deleting transaction")
        var counter = 0

        trackViewModel.$transactions
            .dropFirst()
            .sink { returnedTransaction in
                counter += 1
                if counter == 4{
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        /// Create a mock spenny entity, so that the delete function works
        addTransaction(amount: 50) // --> This will make the first publish
        addTransaction(amount: -23) // --> This will make the second publish
        addTransaction(amount: -69.04) // --> This will make the third publish
        trackViewModel.deleteTransaction(index: IndexSet(integer: 0)) // --> This will make the fourth publish

        waitForExpectations(timeout: timeout)
        XCTAssertEqual(expectedResult, trackViewModel.transactions.count)

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
