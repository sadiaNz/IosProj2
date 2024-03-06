//
//  WordleTests.swift
//  WordleTests
//
//  Created by Mari Batilando on 2/12/23.
//

import XCTest
@testable import Wordle

class WordleTests: XCTestCase {
    
    var boardController: BoardController!

    override func setUp() {
        super.setUp()
        // Initialize the board controller for testing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        boardController = BoardController(collectionView: collectionView)
    }

    override func tearDown() {
        // Clean up resources after testing
        boardController = nil
        super.tearDown()
    }

    func testResetBoard() {
        // Test the resetBoard function
        let settings: [String: Any] = [
            kNumLettersKey: 6,
            kNumGuessesKey: 7,
            kWordThemeKey: "Animals",
            kIsAlienWordleKey: false
        ]
        
        boardController.resetBoard(with: settings)
        
        XCTAssertEqual(boardController.numItemsPerRow, 6)
        XCTAssertEqual(boardController.numRows, 7)
        XCTAssertEqual(boardController.goalWord.count, 6) // Assuming 6 letters in the goal word for the "Animals" theme
        XCTAssertFalse(boardController.isAlienWordle)
    }

    func testEnterCharacter() {
        // Test the enter character function
        boardController.enter("A")
        XCTAssertEqual(boardController.numTimesGuessed, 1)
        XCTAssertEqual(boardController.currRow, 0)
        XCTAssertEqual(boardController.currentGuess, ["A"])  // Updated to an array
    }

    func testDeleteLastCharacter() {
        // Test the delete last character function
        boardController.enter("A")
        boardController.enter("B")
        boardController.deleteLastCharacter()
        XCTAssertEqual(boardController.numTimesGuessed, 1)
        XCTAssertEqual(boardController.currRow, 0)
        XCTAssertEqual(boardController.currentGuess, ["A"])  // Updated to an array
    }

    func testResetBoardWithCurrentSettings() {
        // Test the resetBoardWithCurrentSettings function
        let settings: [String: Any] = [
            kNumLettersKey: 5,
            kNumGuessesKey: 6,
            kWordThemeKey: "Fruits",
            kIsAlienWordleKey: true
        ]

        // Reset the board with initial settings
        boardController.resetBoard(with: settings)

        // Change settings
        let newSettings: [String: Any] = [
            kNumLettersKey: 4,
            kNumGuessesKey: 8,
            kWordThemeKey: "Colors",
            kIsAlienWordleKey: false
        ]

        // Reset the board with the new settings
        boardController.resetBoardWithCurrentSettings()

        XCTAssertEqual(boardController.numItemsPerRow, 4)
        XCTAssertEqual(boardController.numRows, 8)
        XCTAssertEqual(boardController.goalWord.count, 4) // Assuming 4 letters in the goal word for the "Colors" theme
        XCTAssertFalse(boardController.isAlienWordle)
    }

    // Add more test cases as needed

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

