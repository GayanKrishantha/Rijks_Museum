//
//  TemperTest+Extension.swift
//  Temper
//
//  Created by Poornima on 2021-12-18.
//

import Foundation
import XCTest

extension RijksmuseumTestable {
    
    func givenTheAppIsLaunched() {
        XCUIApplication().launch()
    }
    
    func thenUserShouldAllExpectedUIPrppertiesOnArtCollectionPage() {
        XCTAssertTrue(RijksmuseumElements.listView.exists)
        XCTAssertTrue(RijksmuseumElements.navigationTitle.exists)
        XCTAssertTrue(RijksmuseumElements.detailListViewTable.exists)
        XCTAssertTrue(RijksmuseumElements.detailImageView.exists)
    }
    
    func whenUserScrollDownOnArtCollectionView() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.listView)
        XCTAssertTrue(query.status)
        
        // scroll "verticalContentView" as down-wards
        if query.count > 2 {
            RijksmuseumElements.listView.swipeDown(velocity: .default)
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.listView)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
    
    func thenUserShouldSeeMoreData() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.listView)
        XCTAssertTrue(query.status)
        
        if query.count >= 2 {
            XCTAssertTrue(RijksmuseumElements.listView.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.listView.exists)
        }
        
        if query.count > 2 {
            XCTAssertTrue(RijksmuseumElements.listView.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.listView.exists)
        }
    }
    
    func whenUserScrollUpOnArtCollectionView() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.listView)
        XCTAssertTrue(query.status)
        
        if query.count > 2 {
            RijksmuseumElements.listView.swipeUp(velocity: .slow)
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.listView)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
    
    func whenUserTapItemOnList() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.listView)
        XCTAssertTrue(query.status)
        
        if query.count > 2 {
            RijksmuseumElements.listView.tap()
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.listView)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
    
    func thenUserShouldSeeDetailPage() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.detailListViewTable)
        XCTAssertTrue(query.status)
        
        if query.count >= 2 {
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.exists)
        }
        
        if query.count > 2 {
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.exists)
        }
    }
    
    func givenUserTapItemOnList() {
        self.waitForElementAppear()
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.listView)
        XCTAssertTrue(query.status)
        
        if query.count > 2 {
            RijksmuseumElements.listView.tap()
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.listView)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
    
    func givenUserShouldSeeDetailPage() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.detailListViewTable)
        XCTAssertTrue(query.status)
        
        if query.count >= 2 {
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.exists)
        }
        
        if query.count > 2 {
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.cells.element(boundBy:1).isVisible())
            XCTAssertTrue(RijksmuseumElements.detailListViewTable.exists)
        }
    }
    
    func whenUserScrollDetailViewUpWard() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.detailListViewTable)
        XCTAssertTrue(query.status)
        
        if query.count > 2 {
            RijksmuseumElements.detailListViewTable.swipeUp(velocity: .default)
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.detailListViewTable)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
    
    func whenUserScrollDetailViewDownWard() {
        self.waitForElementAppear()
        let query = self.getElemetQuery(element: RijksmuseumElements.detailListViewTable)
        XCTAssertTrue(query.status)
        
        if query.count > 2 {
            RijksmuseumElements.detailListViewTable.swipeDown(velocity: .slow)
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: RijksmuseumElements.predicate),
                                                        object: RijksmuseumElements.detailListViewTable)
            self.waitForExpectation(expectation: expectation, dutration: 3.0)
        }
    }
}

extension RijksmuseumTestable {
    
    private func waitForExpectation(expectation:XCTestExpectation,
                                    dutration: Double,
                                    safe: Bool = false) {
        
        let result: XCTWaiter.Result = XCTWaiter().wait(for: [expectation],
                                                        timeout: dutration)
        if !safe && result != .completed {
            XCTFail("Condition was not satisfied during \(dutration) seconds")
        }
    }
    
    private func getElemetQuery(element: XCUIElement) -> (status:Bool, count: Int) {
        
        let count = element.cells.count
        var type:Bool = false
        if count > 0 {  type = true }
        
        return (type, count)
    }
    
    func scrollElementIfNotVisible(element: XCUIElement,
                                   startCodination: Double? = 0,
                                   endCodination: Double? = 0) {
        
        if !element.isVisible() {
            let startCoord = element.coordinate(withNormalizedOffset: CGVector(dx: startCodination!, dy: 0.5))
            let endCoord = element.coordinate(withNormalizedOffset: CGVector(dx: endCodination!, dy: 0.5))
            startCoord.press(forDuration: 0.05, thenDragTo: endCoord)
        }
    }
    
    func waitForElementAppear() {
        sleep(20)
    }
}

extension XCUIElement {
    
    func isVisible() -> Bool {
        
        guard self.exists && self.isHittable && !self.frame.isEmpty else { return false  }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}

extension XCUIApplication {
    
    func filterCells(containing labels: String...) -> XCUIElementQuery {
        var cells = self.cells
        
        for label in labels {
            cells = cells.containing(NSPredicate(format: "label CONTAINS %@", label))
        }
        return cells
    }
}
