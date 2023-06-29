
//  Created by Gayan Dias on 28/06/2023.


import UIKit

extension ArtDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = detailListView.tableHeaderView as? StretchyTableHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrolllView: detailListView)
    }
}
