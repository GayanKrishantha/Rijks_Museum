//
//  RijksmuseumUITestsLaunchTests.swift
//  RijksmuseumUITests
//
//  Created by Gayan Dias on 23/06/2023.
//

import XCTest

@testable import Rijksmuseum

final class RijksmuseumUITestsLaunchTests: XCTestCase, RijksmuseumTestable {
    
    var expectation:XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        expectation = XCTestExpectation(description: "Download apple.com art search page")
    }
    
    func testArtCollectionScreenShouldHaveExpetedUIElements() {
        
        /// given:
        givenTheAppIsLaunched()
        
        /// when:
        thenUserShouldAllExpectedUIPrppertiesOnArtCollectionPage()
    }
    
    func testUserScrollArtCollectonViewDownWard() {
        
        /// given:
        givenTheAppIsLaunched()
        
        /// when:
        whenUserScrollDownOnArtCollectionView()
        
        /// then:
        thenUserShouldSeeMoreData()
    }
    
    func testUserScrollArtCollectonViewUpWard() {
        
        /// given:
        givenTheAppIsLaunched()
        
        /// when:
        whenUserScrollUpOnArtCollectionView()
        
        /// then:
        thenUserShouldSeeMoreData()
    }
    
    func testUserTapItemOnListView() {
        
        /// given:
        givenTheAppIsLaunched()
        
        /// when:
        whenUserTapItemOnList()
        
        /// then:
        thenUserShouldSeeDetailPage()
    }
    
    func testUserScrollDetailViewUpWard() {
        
        /// given:
        givenTheAppIsLaunched()
        givenUserTapItemOnList()
        givenUserShouldSeeDetailPage()
        
        /// when:
        whenUserScrollDetailViewUpWard()
        
        /// then:
        thenUserShouldSeeMoreData()
    }
    
    func testUserScrollDetailViewDownWard() {
        
        /// given:
        givenTheAppIsLaunched()
        givenUserTapItemOnList()
        givenUserShouldSeeDetailPage()
        
        /// when:
        whenUserScrollDetailViewDownWard()
        
        /// then:
        thenUserShouldSeeMoreData()
    }
}
