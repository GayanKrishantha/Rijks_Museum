
//  Created by Gayan Dias on 28/06/2023.


import UIKit

extension ArtListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: "ArtCollectionHeader",
                                                                         for: indexPath) as! ArtCollectionHeader
        let item = viewModel.sectionValue[indexPath.section].header
        headerView.artTitleLabel.text = item.capitalizingFirstLetter()
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if (indexPath.section == viewModel.sectionValue.count - 2) &&
            (viewModel.page < viewModel.totalPageCount) {
            getApiCall()
        }
    }
}
