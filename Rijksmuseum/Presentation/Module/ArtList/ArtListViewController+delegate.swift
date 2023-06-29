
//  Created by Gayan Dias on 28/06/2023.


import UIKit

extension ArtListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let items = viewModel.sectionValue[indexPath.section].value
        let item = items[indexPath.row]
        viewModel.navigateToDetail(artItem: item)
    }
}
