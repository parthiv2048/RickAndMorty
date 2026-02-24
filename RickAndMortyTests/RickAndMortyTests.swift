//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyTests: XCTestCase {
    
    private var characterSearchVM: CharacterSearchVM?
    private var emptyCharacterSearchVM: CharacterSearchVM?

    override func setUpWithError() throws {
        characterSearchVM = CharacterSearchVM(characters: [], isLoading: true, errorMessage: "No error")
        emptyCharacterSearchVM = CharacterSearchVM()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCharacters() {
        let characters = characterSearchVM?.getCharacters()
        XCTAssertEqual(characters?.count, 0)
        XCTAssertNil(emptyCharacterSearchVM?.getCharacters())
    }
    
    func testGetIsLoading() {
        let isLoading = characterSearchVM?.getIsLoading()
        XCTAssertEqual(isLoading, true)
        XCTAssertNil(emptyCharacterSearchVM?.getIsLoading())
    }
    
    func testGetErrorMessage() {
        let errorMessage = characterSearchVM?.getErrorMessage()
        XCTAssertEqual(errorMessage, "No error")
        XCTAssertNil(emptyCharacterSearchVM?.getErrorMessage())
    }
}
