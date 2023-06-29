//
//  TemperTest+Enum.swift
//  Temper
//
//  Created by Poornima on 2021-12-18.
//

import Foundation
import XCTest

enum RijksmuseumElements {
    
    /// ArtListController _Element and Qquery
    
    static let listView = XCUIApplication().collectionViews["list_collection_view"]
    static let navigationTitle = XCUIApplication().staticTexts["Art collection"]
    
    /// ArtDetailController cell _Element and Qquery
    
    static let detailListViewTable = XCUIApplication().tables["detail_list_view"]
    static let detailImageView = XCUIApplication().tables["detail_list_view_view"].images["detail_image_view_view"]
    
    /// UITest exception
    static let predicate = "exists == true"
}
