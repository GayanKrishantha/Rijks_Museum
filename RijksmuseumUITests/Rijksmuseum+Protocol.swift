import Foundation

protocol RijksmuseumTestable {
    
    /// ArtListViewController
    
    func testArtCollectionScreenShouldHaveExpetedUIElements()

    func testUserScrollArtCollectonViewDownWard()

    func testUserScrollArtCollectonViewUpWard()
    
    /// DetailListViewController
    
    func testUserTapItemOnListView()
    
    func testUserScrollDetailViewUpWard()
    
    func testUserScrollDetailViewDownWard()
}
